import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;

  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _controller.initialize();
      
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print("Camera initialization error: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      if (!_isCameraInitialized) return;
      
      final image = await _controller.takePicture();
      // Yahan aap image ko save ya use kar sakte hain
      print("Picture taken: ${image.path}");
      
      // Picture lene ke baad previous screen pe wapas jao
      Navigator.pop(context);
      
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Camera', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _isCameraInitialized
          ? CameraPreview(_controller)
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF5A5F)),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF5A5F),
        onPressed: _takePicture,
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}