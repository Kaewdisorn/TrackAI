import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS Simulation Client")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(color: Colors.grey[200], height: 50, width: 50),
        /*
        Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: controller.isSimulating
                      ? null
                      : () {
                          controller.startSimulation(5);
                          setState(() {});
                        },
                  child: Text("Start Simulation"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: controller.isSimulating
                      ? () {
                          controller.stopSimulation();
                          setState(() {});
                        }
                      : null,
                  child: Text("Stop Simulation"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: controller.vehicles.length,
                itemBuilder: (_, index) {
                  final v = controller.vehicles[index];
                  return ListTile(
                    title: Text("Vehicle ID: ${v.id}"),
                    subtitle: Text("Lat: ${v.latitude.toStringAsFixed(5)}, "
                        "Lng: ${v.longitude.toStringAsFixed(5)}"),
                  );
                },
              ),
            ),
          ],
        ),*/
      ),
    );
  }
}
