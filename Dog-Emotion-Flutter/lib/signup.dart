// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class SignupScreen extends StatefulWidget {
// //   const SignupScreen({super.key});

// //   @override
// //   _SignupScreenState createState() => _SignupScreenState();
// // }

// // class _SignupScreenState extends State<SignupScreen> {
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();

// //   Future<void> _signup() async {
// //     try {
// //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
// //         email: _emailController.text.trim(),
// //         password: _passwordController.text.trim(),
// //       );

// //       // Add user details to Firestore or Realtime Database here if needed

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Sign Up Successful')),
// //       );
// //       Navigator.pushNamed(context, '/login');
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error: $e')),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Sign Up')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _nameController,
// //               decoration: const InputDecoration(labelText: 'Full Name'),
// //             ),
// //             TextField(
// //               controller: _emailController,
// //               decoration: const InputDecoration(labelText: 'Email'),
// //             ),
// //             TextField(
// //               controller: _passwordController,
// //               decoration: const InputDecoration(labelText: 'Password'),
// //               obscureText: true,
// //             ),
// //             const SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: _signup,
// //               child: const Text('Sign Up'),
// //             ),
// //             TextButton(
// //               onPressed: () => Navigator.pushNamed(context, '/login'),
// //               child: const Text('Back to Login'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   Future<void> _signup() async {
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

//       // Add user details to Firestore or Realtime Database here if needed

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Sign Up Successful')),
//       );
//       // Navigate back to login page
//       Navigator.pushReplacementNamed(context, '/login');
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Sign Up')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Full Name'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _signup,
//               child: const Text('Sign Up'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pushNamed(context, '/login'),
//               child: const Text('Back to Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
