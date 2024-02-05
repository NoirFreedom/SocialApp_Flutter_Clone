import 'dart:io';
import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/features/videos/views/video_preview_screen.dart';
import 'package:TikTok/features/videos/views/widgets/flashModeIconButton.dart';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _deniedPermission = false;
  bool _isSelfieMode = false;
  double _currentZoomLevel = 1.0;
  final double _maxZoomLevel = 5.0;
  final double _minZoomLevel = 1.0;

  late final bool _noCamera = kDebugMode && Platform.isIOS ? true : false;

  late FlashMode _flashMode;
  late CameraController _cameraController;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _CameraButtonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
          vsync: this,
          duration: const Duration(seconds: 10),
          lowerBound: 0.0,
          upperBound: 1.0);

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;
    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    } else {
      _deniedPermission = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      _hasPermission = true;
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickedVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) return;

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }

    super.dispose();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  void _handleZoom(DragUpdateDetails details) {
    double zoomDelta = -details.primaryDelta! / 100;
    _currentZoomLevel += zoomDelta;
    _currentZoomLevel = _currentZoomLevel.clamp(_minZoomLevel, _maxZoomLevel);

    _cameraController.setZoomLevel(_currentZoomLevel);
  }

  @override
  Widget build(BuildContext context) {
    if (_deniedPermission) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog.adaptive(
              title: const Text("Permissions Required"),
              content: const Text(
                  "This app needs camera and microphone permissions to work."),
              actions: <Widget>[
                TextButton(
                  child: const Text("Request Again"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    initPermissions(); // Re-request permissions
                  },
                ),
                TextButton(
                  child: const Text("Exit App"),
                  onPressed: () {
                    SystemNavigator.pop(); // Exit the app
                  },
                ),
              ],
            );
          },
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initializing...",
                    style: TextStyle(fontSize: Sizes.size20),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive()
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(_cameraController),
                  const Positioned(
                    top: 55,
                    left: 15,
                    child: CloseButton(
                      color: Colors.white,
                    ),
                  ),
                  if (!_noCamera)
                    Positioned(
                      top: 55,
                      right: 15,
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.cameraswitch_outlined,
                              size: Sizes.size28,
                            ),
                            color: Colors.white,
                            onPressed: toggleSelfieMode,
                          ),
                          Gaps.v10,
                          FlashModeIconButton(
                            currentFlashMode: _flashMode,
                            flashMode: FlashMode.auto,
                            icon: Icons.flash_auto_outlined,
                            onPressed: () => _flashMode != FlashMode.auto
                                ? _setFlashMode(FlashMode.auto)
                                : _setFlashMode(FlashMode.off),
                          ),
                          Gaps.v10,
                          FlashModeIconButton(
                            currentFlashMode: _flashMode,
                            flashMode: FlashMode.always,
                            icon: _flashMode == FlashMode.always
                                ? Icons.flash_on_outlined
                                : Icons.flash_off_rounded,
                            onPressed: () => _flashMode != FlashMode.always
                                ? _setFlashMode(FlashMode.always)
                                : _setFlashMode(FlashMode.off),
                          ),
                          Gaps.v10,
                          FlashModeIconButton(
                            currentFlashMode: _flashMode,
                            flashMode: FlashMode.torch,
                            icon: _flashMode == FlashMode.torch
                                ? Icons.flashlight_on
                                : Icons.flashlight_off,
                            onPressed: () => _flashMode != FlashMode.torch
                                ? _setFlashMode(FlashMode.torch)
                                : _setFlashMode(FlashMode.off),
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: Sizes.size60,
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onVerticalDragUpdate: _handleZoom,
                            onTapDown: _startRecording,
                            onTapUp: (details) => _stopRecording(),
                            child: ScaleTransition(
                              scale: _CameraButtonAnimation,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: Sizes.size80,
                                    width: Sizes.size80,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircularProgressIndicator(
                                      value: _progressAnimationController.value,
                                      color: Colors.black,
                                      strokeWidth: Sizes.size4,
                                    ),
                                  ),
                                  Container(
                                    height: Sizes.size72,
                                    width: Sizes.size72,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.shade400,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                  onPressed: _onPickedVideoPressed,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.images,
                                    color: Colors.white,
                                  )),
                            ),
                          )
                        ],
                      ))
                ],
              ),
      ),
    );
  }
}
