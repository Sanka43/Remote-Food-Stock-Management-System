import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'product.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> stockItems = [
    {"name": "Rice", "stock": 352, "maxStock": 500},
    {"name": "Dhal", "stock": 50, "maxStock": 80},
    {"name": "Sugar", "stock": 10, "maxStock": 250},
    {"name": "Salt", "stock": 35, "maxStock": 50},
    {"name": "Oil", "stock": 12, "maxStock": 20},
  ];

  DashboardScreen({Key? key}) : super(key: key);

  Map<String, double> getStockDataForPieChart() {
    Map<String, double> data = {};
    for (var item in stockItems) {
      data[item["name"]] = item["stock"].toDouble();
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final stockData = getStockDataForPieChart();

    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9), // Light neutral background
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Inventory Dashboard",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context); // or navigate to login
            },
            icon: Icon(Icons.logout, color: Colors.black),
            label: Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pie Chart
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text("Stock Distribution",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  SizedBox(height: 12),
                  PieChart(
                    dataMap: stockData,
                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    colorList: [
                      Colors.blue[300]!,
                      Colors.green[300]!,
                      Colors.orange[300]!,
                      Colors.red[300]!,
                      Colors.purple[300]!,
                    ],
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                      chartValueStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    legendOptions: LegendOptions(
                      legendTextStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Quick Access Cards Section
            Text("Quick Access",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDashboardCard("Products", Icons.inventory, Colors.blue,
                      onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Product(),
                      ),
                    );
                  }),
                  // _buildDashboardCard("Categories", Icons.category, Colors.orange),
                  _buildDashboardCard("Suppliers", Icons.local_shipping, Colors.green),
                  _buildDashboardCard("Reports", Icons.analytics, Colors.red),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Stock Indicators Section
            Text("Stock Levels",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    stockItems.map((item) => _buildStockItem(context, item)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, Color color,
      {VoidCallback? onPressed}) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 100,
      height: 90,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),// color.withOpacity(0.1), //Light background for cards
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30, color: color),
                SizedBox(height: 0),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStockItem(BuildContext context, Map<String, dynamic> item) {
    double percentage = item["stock"] / item["maxStock"];
    Color progressColor = percentage > 0.5
        ? Colors.green
        : (percentage > 0.2 ? Colors.orange : Colors.red);

    return Container(
  width: 200,
  margin: EdgeInsets.only(right: 16),
  child: Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(item["name"],
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(height: 10),
          CircularStepProgressIndicator(
            totalSteps: 100,
            currentStep: (percentage * 100).clamp(0, 100).toInt(),
            stepSize: 10,
            arcSize: 6,
            selectedColor: progressColor,
            unselectedColor: Colors.grey.shade300,
            padding: 0,
            width: 100,
            height: 100,
            roundedCap: (_, __) => true,
            child: Center(
              child: Text(
                "${(percentage * 100).toInt()}%",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text("${item["stock"]}",
              style: TextStyle(fontSize: 14)),
          if (percentage < 0.2)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () => _showOrderDialog(context, item["name"]),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Order Now"),
              ),
            )
        ],
      ),
    ),
  ),
);
  }

  void _showOrderDialog(BuildContext context, String itemName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Order $itemName"),
          content: Text("Do you want to place a new order for $itemName?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Order placed for $itemName")));
              },
              child: Text("Order"),
            ),
          ],
        );
      },
    );
  }
}
