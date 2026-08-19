import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final List<Map<String, dynamic>> foodItems;

  FoodCard({required this.foodItems});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.restaurant_menu, color: Colors.orange),
                SizedBox(width: 8),
                Text("Food & Drinks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 12),
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  var f = foodItems[index];
                  return Container(
                    width: 180,
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.restaurant, size: 40, color: Colors.orange),
                        SizedBox(height: 8),
                        Text(f["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(f["cuisine"]),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            Text("${f["rating"]}"),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: f["status"] == "Open" ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(f["status"], style: TextStyle(color: Colors.white, fontSize: 12)),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.menu_book),
                  label: Text("View Menu"),
                ),
                SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.directions),
                  label: Text("Get Directions"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
