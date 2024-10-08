import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectiti/pages/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User data variables
  String? email;
  String? name;
  String? imageUrl;

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password.")),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            email = userDoc['email'];
            name = userDoc['name'];
            imageUrl = userDoc['imageUrl'];
          });
          _showUserData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User data not found.")),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed. Please try again.")),
      );
    }
  }

  void _showUserData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageUrl != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(imageUrl!),
                ),
              const SizedBox(height: 10),
              Text('Welcome, $name❤'),
              Text('Your email: $email'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'Category');
                  },
                  child: const Text('OK')),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void openSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (m) => const SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Login',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Welcome back! Nice to see you again',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildTextField(_emailController, 'Email'),
          const SizedBox(height: 10),
          _buildTextField(_passwordController, 'Password', obscureText: true),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: _login,
            color: const Color(0xffF06292),
            textColor: Colors.white,
            child: const Text('Login'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Not yet a member? ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              GestureDetector(
                onTap: openSignup,
                child: const Text(
                  'Sign up now ',
                  style: TextStyle(
                      color: const Color(0xffF06292),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
          ),
        ),
      ),
    );
  }
}
