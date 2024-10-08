import 'package:flutter/material.dart';

import 'cartscreen.dart';
import 'favorite.dart';
import 'fooddetailsscreen.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<Map<String, dynamic>> foodItems = [
    {
      "name": "Classic Cheeseburger",
      "category": "Burgers",
      "price": "\$10",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.25_3a44d160.jpg"
    },
    {
      "name": "Bacon Burger",
      "category": "Burgers",
      "price": "\$12",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.29_f026b418.jpg"
    },
    {
      "name": "Veggie Burger",
      "category": "Burgers",
      "price": "\$9",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.30_6267b15e.jpg"
    },
    {
      "name": "Margherita Pizza",
      "category": "Pizza",
      "price": "\$15",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.27_0c27fc8c.jpg"
    },
    {
      "name": "Pepperoni Pizza",
      "category": "Pizza",
      "price": "\$18",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.28_93e72f28.jpg"
    },
    {
      "name": "Tomato Soup",
      "category": "Soups",
      "price": "\$7",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.26_48212dee.jpg"
    },
    {
      "name": "Chicken Noodle Soup",
      "category": "Soups",
      "price": "\$8",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.26_a1d2820b.jpg"
    },
    {
      "name": "Chicken Fried Rice",
      "category": "Non-Veg",
      "price": "\$12",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.28_4e696a95.jpg"
    },
    {
      "name": "Grilled Salmon",
      "category": "Seafood",
      "price": "\$20",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.30_5710e378.jpg"
    },
    {
      "name": "Spicy Chicken Wings",
      "category": "Spicy Food",
      "price": "\$14",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.26_04779bd8.jpg"
    },
  ];

  List<Map<String, dynamic>> spicyFoodItems = [
    {
      "name": "Spicy Tacos",
      "category": "Spicy Food",
      "price": "\$10",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.26_ec248d3d.jpg",
    },
    {
      "name": "Hot Wings",
      "category": "Spicy Food",
      "price": "\$12",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.29_b11834cb.jpg",
    },
    {
      "name": "Szechuan Chicken",
      "category": "Spicy Food",
      "price": "\$12",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.28_cb7ef6b0.jpg",
    },
    {
      "name": "Peri-Peri Chicken",
      "category": "Spicy Food",
      "price": "\$12",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.27_53be68c8.jpg",
    },
    {
      "name": "Spicy Ramen",
      "category": "Spicy Food",
      "price": "\$12",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.29_7616233e.jpg",
    },
    {
      "name": "Jalapeno Poppers",
      "category": "Spicy Food",
      "price": "\$12",
      "image":
          "assests/images/WhatsApp Image 2024-09-23 at 11.16.29_ca1ea130.jpg",
    },
  ];

  List<Map<String, dynamic>> displayedItems = [];
  List<Map<String, dynamic>> favoriteItems = [];
  List<Map<String, dynamic>> cartItems = [];
  String searchQuery = '';
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    displayedItems = foodItems;
  }

  void updateSearchResults(String query) {
    setState(() {
      searchQuery = query;
      displayedItems = foodItems
          .where((item) =>
              item['name'].toLowerCase().contains(query.toLowerCase()) ||
              item['category'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void toggleFavorite(Map<String, dynamic> item) {
    setState(() {
      if (favoriteItems.contains(item)) {
        favoriteItems.remove(item);
      } else {
        favoriteItems.add(item);
      }
    });
  }

  void navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(favoriteItems: favoriteItems),
      ),
    );
  }

  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: cartItems),
      ),
    );
  }

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.add(item);
      cartItemCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: const Color(0xffF06292),
                onPressed: navigateToCart,
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                updateSearchResults(value);
              },
              decoration: InputDecoration(
                hintText: 'Search food...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: displayedItems.length,
                    itemBuilder: (context, index) {
                      var item = displayedItems[index];
                      return FoodCard(
                        name: item["name"],
                        category: item["category"],
                        price: item["price"],
                        imageUrl: item["image"],
                        isFavorite: favoriteItems.contains(item),
                        toggleFavorite: () => toggleFavorite(item),
                        addToCart: () => addToCart(item),
                        foodItem: item,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'The Most Spicy Food',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[700]),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: spicyFoodItems.length,
                    itemBuilder: (context, index) {
                      var item = spicyFoodItems[index];
                      return FoodCard(
                        name: item["name"],
                        category: item["category"],
                        price: item["price"],
                        imageUrl: item["image"],
                        isFavorite: favoriteItems.contains(item),
                        toggleFavorite: () => toggleFavorite(item),
                        addToCart: () => addToCart(item),
                        foodItem: item,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.pink[300], // Adjust to match your design
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home, color: Colors.white),
                    onPressed: () {
                      // Navigate to the home page or handle navigation
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    onPressed: navigateToFavorites,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      // Add action for floating button
                    },
                    child: const Icon(Icons.add),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: navigateToCart,
                  ),
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String name;
  final String category;
  final String price;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback toggleFavorite;
  final VoidCallback addToCart;
  final Map<String, dynamic> foodItem; // New parameter for food item details

  FoodCard({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
    required this.toggleFavorite,
    required this.addToCart,
    required this.foodItem, // Include the food item here
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the FoodDetailScreen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailScreen(foodItem: foodItem),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      category,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      price,
                      style: TextStyle(color: Colors.orange[700], fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: toggleFavorite,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart,
                              color: Colors.green),
                          onPressed: addToCart,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
