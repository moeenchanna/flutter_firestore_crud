// Imports firebase_core and material Dart packages, and custom files
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // example only, replace with your own file.
import 'screens/screens.dart'; // import screens directory

// The `main` function is the entry point of our Flutter app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebaseApp(); // Initializes Firebase app with its options
  runApp(const MyApp());
}

// This method initializes the Firebase app with its options
Future<void> initializeFirebaseApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  static const String postListRoute = '/';
  static const String addPostRoute = '/addPost';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: postListRoute,
      routes: {
        postListRoute: (context) => const PostList(),
        addPostRoute: (context) => const AddPost(),
      },
    );
  }
}
