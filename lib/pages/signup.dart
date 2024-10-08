import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectiti/pages/loginpage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController =
      TextEditingController(); // Additional name field
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();

  File? _image; // Store the picked image
  bool _isLoading = false; // Show loading indicator

  @override
  void initState() {
    super.initState();
    _initializeFirebase(); // Initialize Firebase on startup
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    print("Firebase initialized");
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _signUp() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _nameController.text.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar("Passwords do not match.");
      return;
    }

    if (_image == null) {
      _showSnackBar("Please select a profile photo.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        // Upload the image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${user.uid}.jpg');
        await storageRef.putFile(_image!);

        // Get the download URL for the uploaded image
        final imageUrl = await storageRef.getDownloadURL();

        // Save the user info in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'email': _emailController.text.trim(),
          'name': _nameController.text.trim(),
          'imageUrl': imageUrl, // Save the image URL
        });

        print("User signed up: ${user.email}");
        _showSnackBar("Sign-up successful.");

        // Navigate to the login page after successful signup
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak.';
          break;
        default:
          errorMessage = 'Sign-up failed. Please try again.';
      }
      _showSnackBar(errorMessage);
    } catch (e) {
      print("Error: $e");
      _showSnackBar("Sign-up failed. Please try again.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void openSignIn() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 130),
              const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Welcome, here you can sign up',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              _buildTextField(_nameController, 'Full Name'),
              const SizedBox(height: 5),
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 5),
              _buildTextField(_passwordController, 'Password',
                  obscureText: true),
              const SizedBox(height: 10),
              _buildTextField(_confirmPasswordController, 'Confirm Password',
                  obscureText: true),
              const SizedBox(height: 17),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text(
                  'Pick Profile Photo',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              _image != null
                  ? Image.file(_image!, height: 100, width: 100)
                  : const Text('No image selected'),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : MaterialButton(
                      onPressed: _signUp,
                      color: const Color(0xffF06292),
                      textColor: Colors.white,
                      child: const Text('Sign Up'),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already a member? ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  GestureDetector(
                    onTap: openSignIn,
                    child: const Text(
                      'Sign in here',
                      style: TextStyle(
                        color: const Color(0xffF06292),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
