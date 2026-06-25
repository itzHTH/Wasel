import 'dart:io' show Platform;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera_overlay_painter.dart';
import 'package:driver/features/driver_verification/ui/widgets/guidance_text.dart';
import 'package:driver/features/driver_verification/ui/widgets/manual_capture_button.dart';

/// Front-camera selfie capture with face-driven auto-capture.
///
/// Pops with the captured [XFile] on success, or `null` if the user backs out.
/// The image stream is stopped and the controller + detector disposed on every
/// exit path (back, capture, app backgrounding).
class SelfieCameraScreen extends StatefulWidget {
  const SelfieCameraScreen({super.key});

  @override
  State<SelfieCameraScreen> createState() => _SelfieCameraScreenState();
}

class _SelfieCameraScreenState extends State<SelfieCameraScreen>
    with WidgetsBindingObserver {
  // Process every Nth streamed frame; auto-capture after this many aligned ones.
  static const _processEveryNthFrame = 3;
  static const _stableFramesNeeded = 10;
  // Heuristic thresholds — tune on-device.
  static const _maxAngleDeg = 12.0;
  static const _minEyeOpen = 0.4;

  static const _deviceOrientationDegrees = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true, // eyes-open probabilities
      performanceMode: FaceDetectorMode.fast,
      minFaceSize: 0.15,
    ),
  );

  CameraController? _controller;
  CameraDescription? _camera;
  String? _error;

  int _frame = 0;
  bool _busy = false;
  bool _isCapturing = false;
  int _stable = 0;
  String _guidance = 'ضع وجهك داخل الإطار';
  bool _aligned = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeController();
    _faceDetector.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (state == AppLifecycleState.resumed) {
      _startCamera();
    } else {
      _disposeController();
    }
  }

  // ── Camera lifecycle ───────────────────────────────────────────────────────

  Future<void> _startCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) setState(() => _error = 'لا توجد كاميرا متاحة');
        return;
      }
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        camera,
        ResolutionPreset.medium, // lower stream resolution for low-end devices
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      await controller.startImageStream(_onImage);
      setState(() {
        _camera = camera;
        _controller = controller;
        _error = null;
      });
    } catch (e) {
      debugPrint('Camera init failed: $e');
      if (mounted) setState(() => _error = 'تعذّر تشغيل الكاميرا');
    }
  }

  Future<void> _disposeController() async {
    final controller = _controller;
    _controller = null;
    if (controller == null) return;
    try {
      if (controller.value.isStreamingImages) {
        await controller.stopImageStream();
      }
    } catch (_) {}
    await controller.dispose();
  }

  // ── Frame processing ───────────────────────────────────────────────────────

  Future<void> _onImage(CameraImage image) async {
    if (_isCapturing) return;
    _frame = (_frame + 1) % _processEveryNthFrame;
    if (_frame != 0 || _busy) return;
    _busy = true;
    try {
      final lowLight = _isLowLight(image);
      final inputImage = _toInputImage(image);
      final faces = inputImage == null
          ? const <Face>[]
          : await _faceDetector.processImage(inputImage);

      final (guidance, aligned) = _evaluate(faces, image, lowLight);
      _stable = aligned ? _stable + 1 : 0;

      if (mounted && (guidance != _guidance || aligned != _aligned)) {
        setState(() {
          _guidance = guidance;
          _aligned = aligned;
        });
      }
      if (aligned && _stable >= _stableFramesNeeded && !_isCapturing) {
        await _capture();
      }
    } catch (e) {
      debugPrint('Face processing error: $e');
    } finally {
      _busy = false;
    }
  }

  (String, bool) _evaluate(List<Face> faces, CameraImage image, bool lowLight) {
    if (lowLight) return ('الإضاءة منخفضة', false);
    if (faces.isEmpty) return ('ضع وجهك داخل الإطار', false);
    if (faces.length > 1) return ('يجب أن يظهر وجه واحد فقط', false);

    final face = faces.first;
    final box = face.boundingBox;
    final ratio = box.width / image.width;
    if (ratio < 0.25) return ('اقترب أكثر', false);
    if (ratio > 0.95) return ('ابتعد قليلاً', false);

    final dx = (box.center.dx - image.width / 2).abs() / image.width;
    final dy = (box.center.dy - image.height / 2).abs() / image.height;
    if (dx > 0.18 || dy > 0.20) return ('وسّط وجهك داخل الإطار', false);

    final yaw = (face.headEulerAngleY ?? 0).abs();
    final roll = (face.headEulerAngleZ ?? 0).abs();
    if (yaw > _maxAngleDeg || roll > _maxAngleDeg) {
      return ('انظر إلى الأمام مباشرة', false);
    }

    final leftEye = face.leftEyeOpenProbability;
    final rightEye = face.rightEyeOpenProbability;
    if (leftEye != null &&
        rightEye != null &&
        (leftEye < _minEyeOpen || rightEye < _minEyeOpen)) {
      return ('افتح عينيك', false);
    }
    return ('ثبّت قليلاً...', true);
  }

  /// Cheap brightness estimate from the luma plane (NV21/Android only).
  bool _isLowLight(CameraImage image) {
    if (image.format.group != ImageFormatGroup.nv21) return false;
    final luma = image.planes.first.bytes;
    if (luma.isEmpty) return false;
    var sum = 0;
    var count = 0;
    for (var i = 0; i < luma.length; i += 64) {
      sum += luma[i];
      count++;
    }
    return count > 0 && sum / count < 50; // 0–255
  }

  /// Converts a streamed [CameraImage] to an ML Kit [InputImage], handling
  /// sensor/device rotation and the per-platform single-plane format. Mirrors
  /// the google_ml_kit example's reference conversion.
  InputImage? _toInputImage(CameraImage image) {
    final camera = _camera;
    final controller = _controller;
    if (camera == null || controller == null) return null;

    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else {
      var compensation =
          _deviceOrientationDegrees[controller.value.deviceOrientation];
      if (compensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        compensation = (sensorOrientation + compensation) % 360;
      } else {
        compensation = (sensorOrientation - compensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(compensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return null;
    if (Platform.isAndroid && format != InputImageFormat.nv21) return null;
    if (Platform.isIOS && format != InputImageFormat.bgra8888) return null;
    if (image.planes.length != 1) return null;

    final plane = image.planes.first;
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  // ── Capture ────────────────────────────────────────────────────────────────

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || _isCapturing) return;
    setState(() => _isCapturing = true);
    try {
      if (controller.value.isStreamingImages) {
        await controller.stopImageStream();
      }
      final file = await controller.takePicture();
      if (!mounted) return;
      Navigator.of(context).pop(file);
    } catch (e) {
      debugPrint('Selfie capture failed: $e');
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      setState(() {
        _isCapturing = false;
        _stable = 0;
      });
      // Resume the stream so the user can try again.
      if (controller.value.isInitialized &&
          !controller.value.isStreamingImages) {
        await controller.startImageStream(_onImage);
      }
      messenger.showSnackBar(
        const SnackBar(content: Text('تعذّر الالتقاط، حاول مجدداً')),
      );
    }
  }

  // ── UI ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary900,
      body: _error != null
          ? _buildError(_error!)
          : (_controller == null || !_controller!.value.isInitialized)
          ? const Center(
              child: CircularProgressIndicator(color: AppColor.neutral0),
            )
          : _buildCamera(_controller!),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.screenHPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.no_photography_outlined,
              size: AppDimens.icon36,
              color: AppColor.neutral0,
            ),
            SizedBox(height: AppDimens.space16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Neutral0SemiBold,
            ),
            SizedBox(height: AppDimens.space24),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'رجوع',
                style: AppTextStyles.font14Primary500SemiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCamera(CameraController controller) {
    final previewSize = controller.value.previewSize;
    return Stack(
      fit: StackFit.expand,
      children: [
        // Cover-fit camera preview.
        if (previewSize != null)
          ClipRect(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: previewSize.height,
                height: previewSize.width,
                child: CameraPreview(controller),
              ),
            ),
          )
        else
          CameraPreview(controller),

        // Dim + oval cutout + ring (green once aligned).
        CustomPaint(
          painter: CameraOverlayPainter(
            borderColor: _aligned
                ? AppColor.alertSuccess500
                : AppColor.neutral0,
          ),
        ),

        // Close button (top-start in RTL).
        SafeArea(
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: EdgeInsets.all(AppDimens.space8),
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColor.neutral0),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),

        // Guidance pill.
        Align(
          alignment: const Alignment(0, 0.45),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
            child: GuidanceText(message: _guidance),
          ),
        ),

        // Manual shutter — always available.
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: AppDimens.space40),
              child: ManualCaptureButton(
                onPressed: _isCapturing ? null : _capture,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
