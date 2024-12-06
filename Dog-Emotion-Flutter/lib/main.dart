// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:io';
// // import 'dart:convert';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Dog Emotion Recognition',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const MyHomePage(title: 'Dog Emotion Recognition'),
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key, required this.title});

// //   final String title;

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   String _actionResult = "No action performed yet.";
// //   bool _isLoading = false;
// //   final ImagePicker _picker = ImagePicker();

// //   // Function to capture video
// //   Future<void> _clickVideo() async {
// //     final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
// //     if (video != null) {
// //       setState(() {
// //         _actionResult = "Video open!";
// //       });
// //       _uploadVideo(File(video.path));
// //     } else {
// //       setState(() {
// //         _actionResult = "No video captured.";
// //       });
// //     }
// //   }

// //   // Function to upload video
// //   Future<void> _uploadVideo(File videoFile) async {
// //     setState(() {
// //       _isLoading = true;
// //       _actionResult = "Uploading video for prediction...";
// //     });

// //     try {
// //       // final uri = Uri.parse(
// //       //     "http://192.168.0.181:5000/predict"); // Update to match your server's IP and port
// //       final uri = Uri.parse("http://82.112.236.118:5555/predict");
// //       final request = http.MultipartRequest('POST', uri);
// //       request.files
// //           .add(await http.MultipartFile.fromPath('videofile', videoFile.path));

// //       final response = await request.send();
// //       final responseBody = await response.stream.bytesToString();

// //       if (response.statusCode == 200) {
// //         final decodedResponse = jsonDecode(responseBody);
// //         setState(() {
// //           _actionResult = "Prediction: ${decodedResponse['prediction']}";
// //         });
// //       } else {
// //         setState(() {
// //           _actionResult = "Error: ${response.statusCode}, ${responseBody}";
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         _actionResult = "Error uploading video: $e";
// //       });
// //     } finally {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// //         title: Text(widget.title),
// //       ),
// //       body: Center(
// //         child: _isLoading
// //             ? const CircularProgressIndicator()
// //             : Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: <Widget>[
// //                   Text(
// //                     _actionResult,
// //                     style: Theme.of(context).textTheme.headlineMedium,
// //                     textAlign: TextAlign.center,
// //                   ),
// //                   const SizedBox(height: 20),
// //                   ElevatedButton.icon(
// //                     onPressed: _clickVideo,
// //                     icon: const Icon(Icons.videocam),
// //                     label: const Text("Capture Video"),
// //                     style: ElevatedButton.styleFrom(
// //                       padding: const EdgeInsets.symmetric(
// //                           vertical: 10, horizontal: 20),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 10),
// //                   ElevatedButton.icon(
// //                     onPressed: () async {
// //                       final XFile? video =
// //                           await _picker.pickVideo(source: ImageSource.gallery);
// //                       if (video != null) {
// //                         _uploadVideo(File(video.path));
// //                       } else {
// //                         setState(() {
// //                           _actionResult = "No video selected.";
// //                         });
// //                       }
// //                     },
// //                     icon: const Icon(Icons.upload_file),
// //                     label: const Text("Upload Video"),
// //                     style: ElevatedButton.styleFrom(
// //                       padding: const EdgeInsets.symmetric(
// //                           vertical: 10, horizontal: 20),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //       ),
// //     );
// //   }
// // }

// --------------------------------------------------------------------------------------------------------------------------------------------------------------
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart'; // Import path_provider
// import 'package:http/http.dart' as http;
// import 'dart:convert'; // For JSON encoding/decoding

// late List<CameraDescription> cameras; // List of available cameras

// void main() async {
//   var ensureInitialized = WidgetsFlutterBinding.ensureInitialized();

//   // Initialize cameras before running the app
//   cameras = await availableCameras();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Remove the debug banner
//       title: 'Dog Emotion Recognition',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const CameraScreen(), // Directly open the camera screen
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _cameraController;
//   bool _isCameraInitialized = false;
//   bool _isRecording = false;
//   late String videoFilePath;
//   String _prediction = "No prediction yet."; // To display the prediction result

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     // Ensure there is at least one available camera
//     if (cameras.isNotEmpty) {
//       _cameraController = CameraController(
//         cameras[0], // Use the first available camera
//         ResolutionPreset.high,
//       );

//       try {
//         await _cameraController.initialize();
//         setState(() {
//           _isCameraInitialized = true;
//         });
//       } catch (e) {
//         debugPrint("Error initializing camera: $e");
//       }
//     } else {
//       debugPrint("No cameras available!");
//     }
//   }

//   // Start/Stop video recording and upload video
//   Future<void> _toggleRecording() async {
//     if (_isRecording) {
//       // Stop recording
//       XFile videoFile = await _cameraController.stopVideoRecording();
//       videoFilePath = videoFile.path; // Get the recorded video file path
//       setState(() {
//         _isRecording = false;
//       });

//       // Upload the video after stopping the recording
//       _uploadVideo(File(videoFile.path));
//     } else {
//       // Start recording
//       final Directory tempDir =
//           await getTemporaryDirectory(); // Get temporary directory
//       videoFilePath =
//           '${tempDir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

//       // Now, start video recording without passing any file path
//       await _cameraController.startVideoRecording();

//       setState(() {
//         _isRecording = true;
//       });
//     }
//   }

//   // Function to upload video to server
//   Future<void> _uploadVideo(File videoFile) async {
//     setState(() {
//       _prediction =
//           "Uploading video for prediction..."; // Show uploading message
//     });

//     try {
//       final uri = Uri.parse("http://82.112.236.118:5001/predict");
//       final request = http.MultipartRequest('POST', uri);
//       request.files
//           .add(await http.MultipartFile.fromPath('videofile', videoFile.path));

//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 200) {
//         final decodedResponse = jsonDecode(responseBody);
//         setState(() {
//           _prediction = "Prediction: ${decodedResponse['prediction']}";
//         });
//       } else {
//         setState(() {
//           _prediction = "Error: ${response.statusCode}, ${responseBody}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _prediction = "Error uploading video: $e";
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Camera Preview
//           _isCameraInitialized
//               ? CameraPreview(_cameraController) // Show the camera preview
//               : const Center(
//                   child:
//                       CircularProgressIndicator(), // Show a loader until the camera initializes
//                 ),
//           // Circular Record Button
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 40.0),
//               child: GestureDetector(
//                 onTap: _toggleRecording,
//                 child: Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: _isRecording ? Colors.red : Colors.white,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.black, width: 2),
//                   ),
//                   child: Center(
//                     child: Icon(
//                       _isRecording ? Icons.stop : Icons.radio_button_checked,
//                       size: 40,
//                       color: _isRecording ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Display prediction result
//           Positioned(
//             bottom: 100,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Text(
//                 _prediction,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   backgroundColor: Colors.black54,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ---------------------------------------------------------------------------------------------------------------------------
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart'; // Import path_provider
// import 'package:http/http.dart' as http;
// import 'dart:convert'; // For JSON encoding/decoding
// import 'package:firebase_core/firebase_core.dart';
// import 'login.dart';
// import 'signup.dart';

// late List<CameraDescription> cameras; // List of available cameras

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // Initialize cameras before running the app
//   cameras = await availableCameras();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Remove the debug banner
//       title: 'Dog Emotion Recognition',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const CameraScreen(), // Directly open the camera screen
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _cameraController;
//   bool _isCameraInitialized = false;
//   bool _isRecording = false;
//   late String videoFilePath;
//   String _prediction = "No prediction yet."; // To display the prediction result

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     // Ensure there is at least one available camera
//     if (cameras.isNotEmpty) {
//       _cameraController = CameraController(
//         cameras[0], // Use the first available camera
//         ResolutionPreset.high,
//       );

//       try {
//         await _cameraController.initialize();
//         setState(() {
//           _isCameraInitialized = true;
//         });
//       } catch (e) {
//         debugPrint("Error initializing camera: $e");
//       }
//     } else {
//       debugPrint("No cameras available!");
//     }
//   }

//   // Start/Stop video recording and upload video
//   Future<void> _toggleRecording() async {
//     if (_isRecording) {
//       // Stop recording
//       XFile videoFile = await _cameraController.stopVideoRecording();
//       videoFilePath = videoFile.path; // Get the recorded video file path
//       setState(() {
//         _isRecording = false;
//       });

//       // Upload the video after stopping the recording
//       _uploadVideo(File(videoFile.path));
//     } else {
//       // Start recording
//       final Directory tempDir =
//           await getTemporaryDirectory(); // Get temporary directory
//       videoFilePath =
//           '${tempDir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

//       // Now, start video recording without passing any file path
//       await _cameraController.startVideoRecording();

//       setState(() {
//         _isRecording = true;
//       });
//     }
//   }

//   // Function to upload video to server
//   Future<void> _uploadVideo(File videoFile) async {
//     setState(() {
//       _prediction =
//           "Uploading video for prediction..."; // Show uploading message
//     });

//     try {
//       final uri = Uri.parse("http://82.112.236.118:5001/predict");
//       final request = http.MultipartRequest('POST', uri);
//       request.files
//           .add(await http.MultipartFile.fromPath('videofile', videoFile.path));

//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//       debugPrint("Backend Response: $responseBody");

//       if (response.statusCode == 200) {
//         final decodedResponse = jsonDecode(responseBody);
//         setState(() {
//           _prediction = "Prediction: ${decodedResponse['prediction']}";
//         });
//       } else {
//         setState(() {
//           _prediction = "Error: ${response.statusCode}, ${responseBody}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _prediction = "Error uploading video: $e";
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Camera Preview
//           _isCameraInitialized
//               ? CameraPreview(_cameraController) // Show the camera preview
//               : const Center(
//                   child:
//                       CircularProgressIndicator(), // Show a loader until the camera initializes
//                 ),

//           // Prediction Text at the Top
//           Positioned(
//             top: 40,
//             left: 16,
//             right: 16,
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 _prediction,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),

//           // Record Button at the Bottom
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 GestureDetector(
//                   onTap: _toggleRecording,
//                   child: Container(
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       color: _isRecording ? Colors.red : Colors.white,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.black, width: 2),
//                     ),
//                     child: Center(
//                       child: Icon(
//                         _isRecording ? Icons.stop : Icons.radio_button_checked,
//                         size: 40,
//                         color: _isRecording ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8), // Add some spacing below the button
//                 Text(
//                   _isRecording ? "Recording..." : "Tap to Record",
//                   style: const TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ----------------------------------------------------------------

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart'; // Import path_provider
// import 'package:http/http.dart' as http;
// import 'dart:convert'; // For JSON encoding/decoding
// import 'login.dart';
// import 'signup.dart';
// import 'package:firebase_core/firebase_core.dart';

// late List<CameraDescription> cameras; // List of available cameras

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   // Initialize cameras before running the app
//   cameras = await availableCameras();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Remove the debug banner
//       title: 'Dog Emotion Recognition',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       initialRoute: '/login', // Start with the login screen
//       routes: {
//         '/login': (context) => const LoginScreen(),
//         '/signup': (context) => const SignupScreen(),
//         '/camera': (context) => const CameraScreen(),
//       },
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _cameraController;
//   bool _isCameraInitialized = false;
//   bool _isRecording = false;
//   late String videoFilePath;
//   String _prediction = "No prediction yet."; // To display the prediction result

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     // Ensure there is at least one available camera
//     if (cameras.isNotEmpty) {
//       _cameraController = CameraController(
//         cameras[0], // Use the first available camera
//         ResolutionPreset.high,
//       );

//       try {
//         await _cameraController.initialize();
//         setState(() {
//           _isCameraInitialized = true;
//         });
//       } catch (e) {
//         debugPrint("Error initializing camera: $e");
//       }
//     } else {
//       debugPrint("No cameras available!");
//     }
//   }

//   // Start/Stop video recording and upload video
//   Future<void> _toggleRecording() async {
//     if (_isRecording) {
//       // Stop recording
//       XFile videoFile = await _cameraController.stopVideoRecording();
//       videoFilePath = videoFile.path; // Get the recorded video file path
//       setState(() {
//         _isRecording = false;
//       });

//       // Upload the video after stopping the recording
//       _uploadVideo(File(videoFile.path));
//     } else {
//       // Start recording
//       final Directory tempDir =
//           await getTemporaryDirectory(); // Get temporary directory
//       videoFilePath =
//           '${tempDir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

//       // Now, start video recording without passing any file path
//       await _cameraController.startVideoRecording();

//       setState(() {
//         _isRecording = true;
//       });
//     }
//   }

//   // Function to upload video to server
//   Future<void> _uploadVideo(File videoFile) async {
//     setState(() {
//       _prediction =
//           "Uploading video for prediction..."; // Show uploading message
//     });

//     try {
//       final uri = Uri.parse("http://82.112.236.118:5001/predict");
//       final request = http.MultipartRequest('POST', uri);
//       request.files
//           .add(await http.MultipartFile.fromPath('videofile', videoFile.path));

//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//       debugPrint("Backend Response: $responseBody");

//       if (response.statusCode == 200) {
//         final decodedResponse = jsonDecode(responseBody);
//         setState(() {
//           _prediction = "Prediction: ${decodedResponse['prediction']}";
//         });
//       } else {
//         setState(() {
//           _prediction = "Error: ${response.statusCode}, ${responseBody}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _prediction = "Error uploading video: $e";
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Camera Preview
//           _isCameraInitialized
//               ? CameraPreview(_cameraController) // Show the camera preview
//               : const Center(
//                   child:
//                       CircularProgressIndicator(), // Show a loader until the camera initializes
//                 ),

//           // Prediction Text at the Top
//           Positioned(
//             top: 40,
//             left: 16,
//             right: 16,
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 _prediction,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),

//           // Record Button at the Bottom
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 GestureDetector(
//                   onTap: _toggleRecording,
//                   child: Container(
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       color: _isRecording ? Colors.red : Colors.white,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.black, width: 2),
//                     ),
//                     child: Center(
//                       child: Icon(
//                         _isRecording ? Icons.stop : Icons.radio_button_checked,
//                         size: 40,
//                         color: _isRecording ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8), // Add some spacing below the button
//                 Text(
//                   _isRecording ? "Recording..." : "Tap to Record",
//                   style: const TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ------------------------------------------------------------------------------------

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'login.dart';
// import 'signup.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'dart:async';

// late List<CameraDescription> cameras;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   cameras = await availableCameras();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Dog Emotion Recognition',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       initialRoute: '/login',
//       routes: {
//         '/login': (context) => const LoginScreen(),
//         '/signup': (context) => const SignupScreen(),
//         '/camera': (context) => const CameraScreen(),
//       },
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _cameraController;
//   bool _isCameraInitialized = false;
//   bool _isRecording = false;
//   late String videoFilePath;
//   String _prediction = "No prediction yet.";
//   int _recordingSeconds = 0;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     if (cameras.isNotEmpty) {
//       _cameraController = CameraController(
//         cameras[0],
//         ResolutionPreset.high,
//       );

//       try {
//         await _cameraController.initialize();
//         setState(() {
//           _isCameraInitialized = true;
//         });
//       } catch (e) {
//         debugPrint("Error initializing camera: $e");
//       }
//     } else {
//       debugPrint("No cameras available!");
//     }
//   }

//   Future<void> _toggleRecording() async {
//     if (_isRecording) {
//       XFile videoFile = await _cameraController.stopVideoRecording();
//       videoFilePath = videoFile.path;
//       setState(() {
//         _isRecording = false;
//         _timer?.cancel();
//         _recordingSeconds = 0;
//       });

//       _uploadVideo(File(videoFile.path));
//     } else {
//       final Directory tempDir = await getTemporaryDirectory();
//       videoFilePath =
//           '${tempDir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

//       await _cameraController.startVideoRecording();

//       setState(() {
//         _isRecording = true;
//         _startTimer();
//       });
//     }
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         _recordingSeconds++;
//       });
//     });
//   }

//   Future<void> _uploadVideo(File videoFile) async {
//     setState(() {
//       _prediction = "Uploading video for prediction...";
//     });

//     try {
//       final uri = Uri.parse("http://82.112.236.118:5001/predict");
//       final request = http.MultipartRequest('POST', uri);
//       request.files
//           .add(await http.MultipartFile.fromPath('videofile', videoFile.path));

//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//       debugPrint("Backend Response: $responseBody");

//       if (response.statusCode == 200) {
//         final decodedResponse = jsonDecode(responseBody);
//         setState(() {
//           _prediction = "Prediction: ${decodedResponse['prediction']}";
//         });
//       } else {
//         setState(() {
//           _prediction = "Error: ${response.statusCode}, ${responseBody}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _prediction = "Error uploading video: $e";
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _isCameraInitialized
//               ? CameraPreview(_cameraController)
//               : const Center(child: CircularProgressIndicator()),
//           Positioned(
//             top: 40,
//             left: 16,
//             right: 16,
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     _prediction,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   if (_isRecording)
//                     Text(
//                       "Recording Time: ${_recordingSeconds}s",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: _toggleRecording,
//               child: Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   color: _isRecording ? Colors.red : Colors.white,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.black, width: 2),
//                 ),
//                 child: Center(
//                   child: Icon(
//                     _isRecording ? Icons.stop : Icons.radio_button_checked,
//                     size: 40,
//                     color: _isRecording ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ------------------------------------------------------------------------------

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // Import path_provider
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding

late List<CameraDescription> cameras; // List of available cameras

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize cameras before running the app
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      title: 'Dog Emotion Recognition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CameraScreen(), // Directly open the camera screen
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _isRecording = false;
  late String videoFilePath;
  String _prediction = "No prediction yet."; // To display the prediction result

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Ensure there is at least one available camera
    if (cameras.isNotEmpty) {
      _cameraController = CameraController(
        cameras[0], // Use the first available camera
        ResolutionPreset.high,
      );

      try {
        await _cameraController.initialize();
        setState(() {
          _isCameraInitialized = true;
        });
      } catch (e) {
        debugPrint("Error initializing camera: $e");
      }
    } else {
      debugPrint("No cameras available!");
    }
  }

  // Start/Stop video recording and upload video
  Future<void> _toggleRecording() async {
    if (_isRecording) {
      // Stop recording
      XFile videoFile = await _cameraController.stopVideoRecording();
      videoFilePath = videoFile.path; // Get the recorded video file path
      setState(() {
        _isRecording = false;
      });

      // Upload the video after stopping the recording
      _uploadVideo(File(videoFile.path));
    } else {
      // Start recording
      final Directory tempDir =
          await getTemporaryDirectory(); // Get temporary directory
      videoFilePath =
          '${tempDir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      // Now, start video recording without passing any file path
      await _cameraController.startVideoRecording();

      setState(() {
        _isRecording = true;
      });
    }
  }

  // Function to upload video to server
  Future<void> _uploadVideo(File videoFile) async {
    setState(() {
      _prediction =
          "Uploading video for prediction..."; // Show uploading message
    });

    try {
      final uri = Uri.parse("http://82.112.236.118:5003/predict");
      final request = http.MultipartRequest('POST', uri);
      request.files
          .add(await http.MultipartFile.fromPath('videofile', videoFile.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      debugPrint("Backend Response: $responseBody");

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(responseBody);
        setState(() {
          _prediction = "Prediction: ${decodedResponse['prediction']}";
        });
      } else {
        setState(() {
          _prediction = "Error: ${response.statusCode}, ${responseBody}";
        });
      }
    } catch (e) {
      setState(() {
        _prediction = "Error uploading video: $e";
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera Preview
          _isCameraInitialized
              ? CameraPreview(_cameraController) // Show the camera preview
              : const Center(
                  child:
                      CircularProgressIndicator(), // Show a loader until the camera initializes
                ),

          // Prediction Text at the Top
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _prediction,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Record Button at the Bottom
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _toggleRecording,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: _isRecording ? Colors.red : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Center(
                      child: Icon(
                        _isRecording ? Icons.stop : Icons.radio_button_checked,
                        size: 40,
                        color: _isRecording ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Add some spacing below the button
                Text(
                  _isRecording ? "Recording..." : "Tap to Record",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
