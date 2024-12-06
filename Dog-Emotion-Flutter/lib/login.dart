// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();

// //   Future<void> _login() async {
// //     try {
// //       await FirebaseAuth.instance.signInWithEmailAndPassword(
// //         email: _emailController.text.trim(),
// //         password: _passwordController.text.trim(),
// //       );
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Login Successful')),
// //       );
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error: $e')),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Login')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _emailController,
// //               decoration:
// //                   const InputDecoration(labelText: 'Email or Full Name'),
// //             ),
// //             TextField(
// //               controller: _passwordController,
// //               decoration: const InputDecoration(labelText: 'Password'),
// //               obscureText: true,
// //             ),
// //             const SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: _login,
// //               child: const Text('Login'),
// //             ),
// //             TextButton(
// //               onPressed: () => Navigator.pushNamed(context, '/signup'),
// //               child: const Text('Sign Up'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   Future<void> _login() async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Login Successful')),
//       );
//       // Navigate to main page
//       Navigator.pushReplacementNamed(context, '/camera');
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration:
//                   const InputDecoration(labelText: 'Email or Full Name'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pushNamed(context, '/signup'),
//               child: const Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
