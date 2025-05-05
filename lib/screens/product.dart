import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  Product({super.key});

  final List<Map<String, dynamic>> productList = [
    {"name": "Rice", "stock": 49, "maxStock": 200},
    {"name": "Dhal", "stock": 70, "maxStock": 80},
    {"name": "Sugar", "stock": 21, "maxStock": 100},
    {"name": "Salt", "stock": 35, "maxStock": 50},
    {"name": "Oil", "stock": 12, "maxStock": 20},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          final stock = product["stock"];
          final maxStock = product["maxStock"];
          final percent = stock / maxStock;
          final percentText = (percent * 100).toStringAsFixed(1);

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: percent,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      percent < 0.3 ? Colors.red : Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$percentText% of $maxStock",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text("Stock: $stock"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
