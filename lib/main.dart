import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectiti/pages/cartscreen.dart';
import 'package:projectiti/pages/categorypage.dart';
import 'package:projectiti/pages/homepage.dart';
import 'package:projectiti/pages/loginpage.dart';
import 'package:projectiti/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Category': (context) => CategoryPage(),
        'signup': (context) => const SignUp(),
        'login': (context) => const Login(),
        'home': (context) => const Homepage(),
      },
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
    );
  }
}
