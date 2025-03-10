import 'package:flutter/material.dart';

class ScheduleResultScreen extends StatelessWidget {
  final String scheduleResult;

  const ScheduleResultScreen({super.key, required this.scheduleResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hasil Jadwal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📅 Jadwal Anda:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: scheduleResult.split("\n").length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: SelectableText(
                      scheduleResult.split("\n")[index],
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pop(context), // Kembali ke HomeScreen
                child: Text("🔙 Kembali"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
