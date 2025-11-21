import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/home.dart';
import '../widgets/location_search.dart';
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
    homeController.routePointsNotifier.dispose();
    super.dispose();
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
                  child: LocationSearch(textfieldController: homeController.startController, labelText: "Start Location"),
                ),
                const SizedBox(width: 8),
                ValueListenableBuilder<SimulationState>(
                  valueListenable: homeController.simulationState,
                  builder: (context, state, _) {
                    return SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state == SimulationState.initial ? Colors.blue : Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: state == SimulationState.initial ? homeController.setRoute : null,
                        child: const Text("Set Route"),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            // End Row
            Row(
              children: [
                Expanded(
                  child: LocationSearch(textfieldController: homeController.endController, labelText: "End Location"),
                ),
                const SizedBox(width: 8),
                ValueListenableBuilder<SimulationState>(
                  valueListenable: homeController.simulationState,
                  builder: (context, state, _) {
                    return SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state == SimulationState.initial ? Colors.blue : Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: state == SimulationState.initial ? homeController.clearRoute : null,
                        child: const Text("Clear Route"),
                      ),
                    );
                  },
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
                ValueListenableBuilder<List<LatLng>>(
                  valueListenable: homeController.routePointsNotifier,
                  builder: (context, routePoints, _) {
                    return ValueListenableBuilder<SimulationState>(
                      valueListenable: homeController.simulationState,
                      builder: (context, state, _) {
                        switch (state) {
                          case SimulationState.initial:
                            return ElevatedButton.icon(
                              icon: const Icon(Icons.play_arrow),
                              label: const Text("Start Simulation"),
                              onPressed: routePoints.isNotEmpty ? homeController.startSimulation : null,
                            );

                          case SimulationState.running:
                            return Row(
                              children: [
                                ElevatedButton.icon(icon: const Icon(Icons.pause), label: const Text("Pause"), onPressed: homeController.pauseSimulation),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(icon: const Icon(Icons.stop), label: const Text("Reset"), onPressed: homeController.resetSimulation),
                              ],
                            );

                          case SimulationState.paused:
                            return Row(
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text("Resume"),
                                  onPressed: homeController.resumeSimulation,
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(icon: const Icon(Icons.stop), label: const Text("Reset"), onPressed: homeController.resetSimulation),
                              ],
                            );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Map placeholder
            Expanded(
              child: RouteMap(
                key: homeController.mapKey,
                start: homeController.startLatLng,
                destination: homeController.endLatLng,
                routePointsNotifier: homeController.routePointsNotifier,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
