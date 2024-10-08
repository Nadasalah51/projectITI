import 'package:flutter/material.dart';
import 'package:projectiti/pages/invoicecall.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<int, int> quantities;

  @override
  void initState() {
    super.initState();
    quantities = Map.fromIterable(
      List.generate(widget.cartItems.length, (index) => index),
      value: (index) => 1,
    );
  }

  void navigateToInvoice() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            InvoiceScreen(cartItems: widget.cartItems, quantities: quantities),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cartItems.fold(0, (sum, item) {
      String priceString = item['price']?.replaceAll('\$', '') ?? '0';
      return sum +
          (double.tryParse(priceString) ?? 0) *
              quantities[widget.cartItems.indexOf(item)]!;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: const Color(0xffF06292),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.cartItems.isEmpty
                ? const Center(
                    child: Text('No items in cart.',
                        style: TextStyle(fontSize: 18)))
                : ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      var item = widget.cartItems[index];
                      double itemPrice = (double.tryParse(
                                  item['price']?.replaceAll('\$', '') ?? '0') ??
                              0) *
                          quantities[index]!;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          title: Text(
                            item['name'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['category'],
                                  style: TextStyle(color: Colors.grey[700])),
                              const SizedBox(height: 5),
                              Text('Price per item: \$${item['price']}',
                                  style: TextStyle(color: Colors.green[600])),
                              Text(
                                  'Total Price: \$${itemPrice.toStringAsFixed(2)}',
                                  style: TextStyle(color: Colors.green[600])),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove,
                                    color: const Color(0xffF06292)),
                                onPressed: () {
                                  setState(() {
                                    if (quantities[index]! > 1) {
                                      quantities[index] =
                                          quantities[index]! - 1;
                                    }
                                  });
                                },
                              ),
                              Text('${quantities[index]}',
                                  style: const TextStyle(fontSize: 18)),
                              IconButton(
                                icon: const Icon(Icons.add,
                                    color: const Color(0xffF06292)),
                                onPressed: () {
                                  setState(() {
                                    quantities[index] = quantities[index]! + 1;
                                  });
                                },
                              ),
                            ],
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: navigateToInvoice,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF06292),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                'Complete Order',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
