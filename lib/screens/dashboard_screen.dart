import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'product.dart';

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> stockItems = [
    {"name": "Rice", "stock": 50, "maxStock": 100},
    {"name": "Dhal", "stock": 20, "maxStock": 100},
    {"name": "Sugar", "stock": 70, "maxStock": 100},
    {"name": "Salt", "stock": 10, "maxStock": 100},
    {"name": "Oil", "stock": 90, "maxStock": 100},
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
      backgroundColor: Color(0xFF0f2027),
      appBar: AppBar(
  automaticallyImplyLeading: false, // 🔥 Removes back button
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: Text(
    "Inventory Dashboard",
    style: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  actions: [
    TextButton.icon(
      onPressed: () {
        // Add your logout logic here
        Navigator.pop(context); // or navigate to login screen
      },
      icon: Icon(Icons.logout, color: Colors.white),
      label: Text(
        "Logout",
        style: TextStyle(color: Colors.white),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    SizedBox(width: 12),
  ],
),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            // Pie Chart Card
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                // gradient: LinearGradient(
                //   colors: [Colors.tealAccent.shade400, Colors.teal.shade700],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.black26,
                  //   blurRadius: 20,
                  //   offset: Offset(0, 6),
                  // )
                ],
              ),
              child: Column(
                children: [
                  Text("Stock Distribution",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255))),
                  SizedBox(height: 16),
                  PieChart(
                    dataMap: stockData,
                    chartRadius: MediaQuery.of(context).size.width / 2.4,
                    colorList: [
                      Colors.blue,
                      Colors.orange,
                      Colors.purple,
                      Colors.red,
                      Colors.green
                    ],
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                      chartValueStyle: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                    ),
                    legendOptions: LegendOptions(
                      legendTextStyle: TextStyle(color: const Color.fromARGB(255, 255, 244, 244)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Dashboard Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDashboardCard("Products", Icons.inventory, Colors.blueAccent, 
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Product(),
                      ),
                    );
                  }),
                  _buildDashboardCard("Categories", Icons.category, Colors.amber),
                  _buildDashboardCard("Suppliers", Icons.local_shipping, Colors.purple),
                  _buildDashboardCard("Reports", Icons.analytics, Colors.deepOrange),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Stock Indicators
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Stock Levels",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            SizedBox(height: 12),
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

  Widget _buildDashboardCard(String title, IconData icon, Color color, {VoidCallback? onPressed}) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 8,
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                Icon(icon, size: 36, color: color),
                SizedBox(height: 10),
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 8,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(item["name"],
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              CircularPercentIndicator(
                radius: 60,
                lineWidth: 10,
                percent: percentage > 1.0 ? 1.0 : percentage,
                center: Text("${(percentage * 100).toInt()}%",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                progressColor: progressColor,
                backgroundColor: Colors.grey.shade300,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              SizedBox(height: 8),
              Text("${item["stock"]} / ${item["maxStock"]}",
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
