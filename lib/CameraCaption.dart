// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// late List<CameraDescription> _cameras;
//
// Future<void> CameraRun() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;
//
//   runApp(CameraCaption(firstCamera));
// }
//
// /// CameraApp is the Main Application.
// class CameraCaption extends StatefulWidget {
//   final CameraDescription camera;
//   CameraCaption(this.camera);
//   @override
//   _CameraCaption createState() => _CameraCaption();
// }
//
// class _CameraCaption extends State<CameraCaption> {
//   CameraController? _controller;
//   Future<void>? _initializeControllerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.ultraHigh,
//     );
//
//     _initializeControllerFuture = _controller?.initialize();
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: Text('Take a picture')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller!);
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           try {
//             await _initializeControllerFuture;
//
//             final path = await takePicture();
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => DisplayPictureScreen(imagePath: path),
//               ),
//             );
//           } catch (e) {
//             print('Error taking picture: $e');
//           }
//         },
//         child: Icon(Icons.camera_alt),
//       ),
//
//     )
//     );
//   }
//
//   Future<String> takePicture() async {
//     if (!_controller!.value.isInitialized) {
//       return '';
//     }
//
//     try {
//       final picture = await _controller!.takePicture();
//       return picture.path;
//     } catch (e) {
//       return '';
//     }
//   }
// }
//
// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;
//
//   DisplayPictureScreen({required this.imagePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Display the picture')),
//       body: Center(
//         child: Image.file(File(imagePath)),
//       ),
//     );
//   }
// }
