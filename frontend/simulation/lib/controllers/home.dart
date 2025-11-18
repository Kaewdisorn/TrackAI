import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/map.dart';

enum SimulationState { initial, running, paused }

class HomeController {
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final ValueNotifier<List<LatLng>> routePointsNotifier = ValueNotifier([]);
  final GlobalKey<RouteMapState> mapKey = GlobalKey<RouteMapState>();
  final simulationState = ValueNotifier<SimulationState>(SimulationState.initial);

  final List<String> sampleLocations = ['Seoul', 'Busan', 'Incheon', 'Daejeon', 'Daegu'];
  LatLng? startLatLng;
  LatLng? endLatLng;
  List<LatLng> routePoints = [];

  void startSimulation() {
    if (mapKey.currentState != null && routePointsNotifier.value.isNotEmpty) {
      mapKey.currentState!.startSimulation(routePointsNotifier.value);
      simulationState.value = SimulationState.running;
    }
  }

  void pauseSimulation() {
    if (mapKey.currentState != null) {
      mapKey.currentState!.pauseSimulation();
      simulationState.value = SimulationState.paused;
    }
  }

  void resumeSimulation() {
    if (mapKey.currentState != null) {
      mapKey.currentState!.resumeSimulation();
      simulationState.value = SimulationState.running;
    }
  }

  void setRoute() {
    startLatLng = LatLng(37.5665, 126.9780); // Seoul
    endLatLng = LatLng(35.1796, 129.0756); // Busan
    routePoints = generateRoute(startLatLng!, endLatLng!);
    routePointsNotifier.value = routePoints;
  }

  void clearRoute() {
    startController.clear();
    endController.clear();
    startLatLng = null;
    endLatLng = null;
    routePoints = [];
    routePointsNotifier.value = routePoints;
  }

  List<LatLng> generateRoute(LatLng start, LatLng end, {int segments = 20}) {
    List<LatLng> points = [];
    for (int i = 0; i <= segments; i++) {
      double lat = start.latitude + (end.latitude - start.latitude) * (i / segments);
      double lng = start.longitude + (end.longitude - start.longitude) * (i / segments);
      points.add(LatLng(lat, lng));
    }
    return points;
  }
}
