import 'package:flutter/material.dart';
import '../widgets/location_search_field.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  @override
  void dispose() {
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> sampleLocations = ['Seoul', 'Busan', 'Incheon', 'Daejeon', 'Daegu'];

    return Scaffold(
      appBar: AppBar(title: const Text("GPS Simulation Client")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Start Row
            Row(
              children: [
                Expanded(
                  child: LocationSearchField(controller: startController, labelText: 'Start Location', options: sampleLocations),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(onPressed: () => debugPrint("Start: ${startController.text}"), child: const Text("Start")),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // End Row
            Row(
              children: [
                Expanded(
                  child: LocationSearchField(controller: endController, labelText: 'End Location', options: sampleLocations),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(onPressed: () => debugPrint("End: ${endController.text}"), child: const Text("End")),
                ),
              ],
            ),

            const SizedBox(height: 12),
            // Vehicle ID Row
            Row(
              children: [
                const Text("Vehicle ID :", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                const Text("001", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),

            // Map placeholder
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text("Map Placeholder")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
