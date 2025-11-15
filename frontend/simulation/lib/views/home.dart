import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/home.dart';
import '../widgets/map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final HomeController homeController = HomeController();

  final TextEditingController startController = TextEditingController();
  final TextEditingController destController = TextEditingController();

  Future<void> setLocation(String query, bool isStart) async {
    try {
      await homeController.setLocation(query, isStart);
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // Example start & destination
  final LatLng start = LatLng(37.5665, 126.9780);
  final LatLng destination = LatLng(37.5651, 126.9895);

  final List<LatLng> routePoints = [LatLng(37.5665, 126.9780), LatLng(37.5660, 126.9800), LatLng(37.5655, 126.9850), LatLng(37.5651, 126.9895)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GPS Simulation Client")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Map widget
            Expanded(
              child: RouteMap(start: start, destination: destination, routePoints: routePoints),
            ),
            const SizedBox(height: 16),
            // Example buttons (optional)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Start simulation logic
                  },
                  child: const Text("Start Simulation"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Stop simulation logic
                  },
                  child: const Text("Stop Simulation"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
