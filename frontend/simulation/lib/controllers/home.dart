import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class HomeController {
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  final List<String> sampleLocations = ['Seoul', 'Busan', 'Incheon', 'Daejeon', 'Daegu'];
  LatLng? startLatLng;
  LatLng? endLatLng;
  List<LatLng> routePoints = [];

  void setRoute() {
    startLatLng = LatLng(37.5665, 126.9780); // Seoul
    endLatLng = LatLng(35.1796, 129.0756); // Busan
    routePoints = generateRoute(startLatLng!, endLatLng!);
  }

  void clearRoute() {
    startController.clear();
    endController.clear();
    startLatLng = null;
    endLatLng = null;
    routePoints = [];
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
