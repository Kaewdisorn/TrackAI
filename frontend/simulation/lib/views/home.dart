import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/home.dart';
import '../widgets/location_search_field.dart';
import '../widgets/map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final HomeController homeController = HomeController();
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  @override
  void dispose() {
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  void onSetRoute() {
    setState(() {
      homeController.setRoute();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: LocationSearchField(controller: startController, labelText: 'Start Location', options: homeController.sampleLocations),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(onPressed: () => onSetRoute(), child: const Text("Set Route")),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // End Row
            Row(
              children: [
                Expanded(
                  child: LocationSearchField(controller: endController, labelText: 'End Location', options: homeController.sampleLocations),
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
              child: RouteMap(start: homeController.startLatLng, destination: homeController.endLatLng, routePoints: homeController.routePoints),
            ),
          ],
        ),
      ),
    );
  }
}
