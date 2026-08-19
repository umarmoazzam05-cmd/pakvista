import 'package:flutter/material.dart';

class SafetyAlertCard extends StatelessWidget {
  final List<Map<String, dynamic>> alerts;

  SafetyAlertCard({required this.alerts});

  Color getAlertColor(String severity) {
    switch (severity) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

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
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 8),
                Text("Safety Alerts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 12),
            Column(
              children: alerts.map((alert) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: getAlertColor(alert["severity"]).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        alert["type"] == "Weather"
                            ? Icons.cloud
                            : alert["type"] == "Health"
                                ? Icons.health_and_safety
                                : Icons.local_police,
                        color: getAlertColor(alert["severity"]),
                      ),
                      SizedBox(width: 8),
                      Expanded(child: Text(alert["message"])),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: getAlertColor(alert["severity"]),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(alert["severity"], style: TextStyle(color: Colors.white, fontSize: 12)),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.info),
                  label: Text("View Details"),
                ),
                SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.phone),
                  label: Text("Emergency Contacts"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
