import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_capture_view.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_error_view.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_overlay_painter.dart';

/// Generalised manual camera capture used across driver verification.
///
/// Renders a cover-fit preview with a dimmed [CameraOverlayPainter] cutout,
/// static [GuidanceText], and a [ManualCaptureButton]. The user frames the shot
/// and taps the shutter — there is no auto-capture and no on-device ML.
///
/// Camera permission is gated via [ensurePermission] *before* the controller is
/// created; if it is refused the screen pops with `null`. Pops with the captured
/// [XFile] on success, or `null` if the user backs out. The controller is
/// disposed on every exit path (back, capture, app backgrounding).
class CameraCaptureScreen extends StatefulWidget {
  /// Shape of the framing cutout (rect for documents, oval for the selfie).
  final CutoutShape cutoutShape;

  /// Which physical camera to use (back for documents, front for the selfie).
  final CameraLensDirection lensDirection;

  /// Static instruction shown in the guidance pill.
  final String guidanceText;

  /// Capture quality. Documents default to high for legibility; callers may pass
  /// a lower preset (e.g. medium for the selfie) to ease low-end devices.
  final ResolutionPreset resolution;

  /// Cutout width as a fraction of the available width (passthrough to painter).
  final double widthFactor;

  /// Cutout height / width (passthrough to painter).
  final double aspectRatio;

  const CameraCaptureScreen({
    super.key,
    required this.cutoutShape,
    required this.lensDirection,
    required this.guidanceText,
    this.resolution = ResolutionPreset.high,
    this.widthFactor = 0.72,
    this.aspectRatio = 1.3,
  });

  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen>
    with WidgetsBindingObserver {
  final ValueNotifier<CameraController?> _controller = ValueNotifier(null);
  final ValueNotifier<String?> _error = ValueNotifier(null);
  final ValueNotifier<bool> _isCapturing = ValueNotifier(false);
  // True once the camera permission has been granted; gates lifecycle restarts.
  bool _permissionGranted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.value?.dispose();
    _controller.dispose();
    _error.dispose();
    _isCapturing.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_permissionGranted) return;
    if (state == AppLifecycleState.resumed) {
      if (_controller.value == null) _startCamera();
    } else {
      _disposeController();
    }
  }

  // ── Init & permission ────────────────────────────────────────────────────────

  Future<void> _init() async {
    final granted = await ensurePermission(
      context,
      Permission.camera,
      deniedTitle: 'إذن الكاميرا مطلوب',
      deniedMessage: 'نحتاج إذن الكاميرا لالتقاط الصورة. فعّله من الإعدادات.',
    );
    if (!mounted) return;
    if (!granted) {
      Navigator.of(context).pop();
      return;
    }
    _permissionGranted = true;
    await _startCamera();
  }

  // ── Camera lifecycle ─────────────────────────────────────────────────────────

  Future<void> _startCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) _error.value = 'لا توجد كاميرا متاحة';
        return;
      }
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == widget.lensDirection,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        camera,
        widget.resolution,
        enableAudio: false,
      );
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      _error.value = null;
      _controller.value = controller;
    } catch (e) {
      debugPrint('Camera init failed: $e');
      if (mounted) _error.value = 'تعذّر تشغيل الكاميرا';
    }
  }

  Future<void> _disposeController() async {
    final controller = _controller.value;
    _controller.value = null;
    if (controller == null) return;
    await controller.dispose();
  }

  // ── Capture ──────────────────────────────────────────────────────────────────

  Future<void> _capture() async {
    final controller = _controller.value;
    if (controller == null || _isCapturing.value) return;
    _isCapturing.value = true;
    try {
      final file = await controller.takePicture();
      if (!mounted) return;
      Navigator.of(context).pop(file);
    } catch (e) {
      debugPrint('Capture failed: $e');
      if (!mounted) return;
      _isCapturing.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّر الالتقاط، حاول مجدداً')),
      );
    }
  }

  // ── UI ───────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary900,
      body: ListenableBuilder(
        listenable: Listenable.merge([_controller, _error]),
        builder: (context, _) {
          final error = _error.value;
          final controller = _controller.value;
          if (error != null) {
            return CameraErrorView(
              message: error,
              onBack: () => Navigator.of(context).pop(),
            );
          }
          if (controller == null || !controller.value.isInitialized) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.neutral0),
            );
          }
          return CameraCaptureView(
            controller: controller,
            cutoutShape: widget.cutoutShape,
            widthFactor: widget.widthFactor,
            aspectRatio: widget.aspectRatio,
            guidanceText: widget.guidanceText,
            isCapturing: _isCapturing,
            onCapture: _capture,
            onClose: () => Navigator.of(context).pop(),
          );
        },
      ),
    );
  }
}
