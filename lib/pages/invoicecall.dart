import 'package:flutter/material.dart';

class InvoiceScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Map<int, int> quantities;

  InvoiceScreen({required this.cartItems, required this.quantities});

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    Map<String, int> itemCounts = {};

    for (var index = 0; index < cartItems.length; index++) {
      var item = cartItems[index];
      String priceString = item['price']?.replaceAll('\$', '') ?? '0';
      double itemPrice = double.tryParse(priceString) ?? 0.0;
      totalPrice += itemPrice * quantities[index]!;

      if (itemCounts.containsKey(item['name'])) {
        itemCounts[item['name']] =
            itemCounts[item['name']]! + quantities[index]!;
      } else {
        itemCounts[item['name']] = quantities[index]!;
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            color: Colors.white,
            elevation: 19,
            borderRadius: BorderRadius.circular(25),
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Receipt Details',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...itemCounts.entries.map((entry) {
                    String itemName = entry.key;
                    int itemCount = entry.value;
                    double itemPrice = double.tryParse(cartItems
                                .firstWhere(
                                    (item) => item['name'] == itemName)['price']
                                ?.replaceAll('\$', '') ??
                            '0') ??
                        0.0;
                    double totalItemPrice = itemCount * itemPrice;

                    return Column(
                      children: [
                        buildItemRow(
                            'Number of $itemName:', itemCount.toString()),
                        buildItemRow('Total $itemName:',
                            '\$${totalItemPrice.toStringAsFixed(2)}'),
                      ],
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  const Text(
                    'Total for All Items:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                    child: Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItemRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
