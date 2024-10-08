import 'package:flutter/material.dart';

class FoodDetailScreen extends StatelessWidget {
  final Map<String, dynamic> foodItem;
  FoodDetailScreen({super.key, required this.foodItem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(foodItem['image']),
              const SizedBox(height: 16),
              Text(
                foodItem['name'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                foodItem['category'],
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              Text(
                foodItem['price'],
                style: TextStyle(fontSize: 20, color: Colors.orange[700]),
              ),
              const SizedBox(height: 16),
              // Add more details if needed
            ],
          ),
        ),
      ),
    );
  }
}
