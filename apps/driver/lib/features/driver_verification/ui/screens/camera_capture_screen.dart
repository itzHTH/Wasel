import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_capture_view.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_error_view.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_overlay_painter.dart';

class CameraCaptureScreen extends StatefulWidget {
  final CutoutShape cutoutShape;

  final CameraLensDirection lensDirection;

  final String guidanceText;

  final ResolutionPreset resolution;

  final double widthFactor;

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
    // Deferred a frame: the permission prompt reads Localizations, which
    // cannot be looked up while initState is still running.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _init();
    });
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
      deniedTitle: context.l10n.cameraPermissionRequired,
      deniedMessage: context.l10n.cameraPermissionMessage,
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
        if (mounted) _error.value = context.l10n.noCameraAvailable;
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
    } catch (_) {
      if (mounted) _error.value = context.l10n.cameraStartFailed;
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
    } catch (_) {
      if (!mounted) return;
      _isCapturing.value = false;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.captureFailed)));
    }
  }

  // ── UI ───────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scrim,
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
            return AppLoadingOverlay(backgroundColor: context.colors.scrim);
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
