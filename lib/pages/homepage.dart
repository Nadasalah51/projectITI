import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF7FE), // Background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Gusto',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffF06292),
                  letterSpacing: 2.0,
                  fontFamily: 'Pacifico',
                ),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                    'assests/images/WhatsApp Image 2024-09-23 at 23.31.21_70c9e4b5.jpg'), // Add your own image here
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Enjoy Your',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                'Favourite Dishes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffF06292),
                ),
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Category');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF06292),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 30),

              // Image.asset(
              //   'assests/images/images (1).jpeg', // Add your own decoration image
              //   width: 100,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
