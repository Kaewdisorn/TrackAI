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
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GPS Simulation Client")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: TextField(
                              controller: startController,
                              decoration: InputDecoration(labelText: 'Start Location', border: OutlineInputBorder()),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                final startLocation = startController.text;
                                final endLocation = endController.text;
                                debugPrint("Start: $startLocation");
                              },
                              child: const Text("Start"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: TextField(
                              controller: endController,
                              decoration: InputDecoration(labelText: 'End Location', border: OutlineInputBorder()),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                final startLocation = startController.text;
                                final endLocation = endController.text;
                                debugPrint("End: $endLocation");
                              },
                              child: const Text("Clear"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12.0),
              ],
            ),

            const SizedBox(height: 16.0),

            // Map Widget Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text("Map Placeholder")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
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
            // Top controls: Left (fields) + Right (buttons)
            Row(
              children: [
                // Left: TextFields
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: startController,
                          decoration: const InputDecoration(labelText: "Start Location", border: OutlineInputBorder()),
                          //onSubmitted: (value) => _setLocation(value, true),
                          onSubmitted: (value) => debugPrint('Start submitted: $value'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TextField(
                          controller: destController,
                          decoration: const InputDecoration(labelText: "Destination", border: OutlineInputBorder()),
                          //onSubmitted: (value) => _setLocation(value, false),
                          onSubmitted: (value) => debugPrint('Destination submitted: $value'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Right: Buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (startController.text.isNotEmpty) {
                          //_setLocation(startController.text, true);
                        }
                        if (destController.text.isNotEmpty) {
                          // _setLocation(destController.text, false);
                        }
                      },
                      child: const Text("Start"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // controller.clear();

                        setState(() {});
                      },
                      child: const Text("Clear"),
                    ),
                  ],
                ),
              ],
            ),
            /////////////////////////////////////////////////////////

            // Map widget
            /*
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
            */
          ],
        ),
      ),
    );
  }
}
*/
