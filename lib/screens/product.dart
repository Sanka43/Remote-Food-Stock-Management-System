import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  Product({super.key});

  final List<Map<String, dynamic>> productList = [
    {
      "name": "Tomatoes",
      "stock": 80,
      "price": 2.5,
      "description": "Fresh red tomatoes",
    },
    {
      "name": "Potatoes",
      "stock": 50,
      "price": 1.8,
      "description": "Organic farm potatoes",
    },
    {
      "name": "Onions",
      "stock": 30,
      "price": 2.0,
      "description": "Imported purple onions",
    },
    {
      "name": "Milk",
      "stock": 2,
      "price": 4.5,
      "description": "Dairy fresh milk",
    },
    {
      "name": "Eggs",
      "stock": 5,
      "price": 0.5,
      "description": "Farm eggs - pack of 6",
    },
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
                  Text(
                    product["description"],
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text("Stock: ${product["stock"]}"),
                  Text("Price: \$${product["price"].toStringAsFixed(2)}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
