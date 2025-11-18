import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    homeController.startController.dispose();
    homeController.endController.dispose();
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
                  child: LocationSearchField(controller: homeController.startController, labelText: 'Start Location', options: homeController.sampleLocations),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                    onPressed: () => onSetRoute(),
                    child: const Text("Set Route"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // End Row
            Row(
              children: [
                Expanded(
                  child: LocationSearchField(controller: homeController.endController, labelText: 'End Location', options: homeController.sampleLocations),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                    onPressed: () {
                      setState(() {
                        homeController.clearRoute();
                      });
                    },
                    child: const Text("Clear"),
                  ),
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
                const SizedBox(width: 8),
                SizedBox(
                  width: 170,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                    onPressed: () => {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Start Simulation"),
                  ),
                ),
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
