import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteMap extends StatefulWidget {
  final LatLng start;
  final LatLng destination;
  final List<LatLng> routePoints;

  const RouteMap({super.key, required this.start, required this.destination, required this.routePoints});

  @override
  RouteMapState createState() => RouteMapState();
}

class RouteMapState extends State<RouteMap> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    // Move map to center between start & destination
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final centerLat = (widget.start.latitude + widget.destination.latitude) / 2;
      final centerLng = (widget.start.longitude + widget.destination.longitude) / 2;
      _mapController.move(LatLng(centerLat, centerLng), 15.0); // zoom 15
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: widget.start, // initial center
        initialZoom: 15.0,
        minZoom: 3,
        maxZoom: 18,
      ),
      children: [
        TileLayer(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: const ['a', 'b', 'c']),
        PolylineLayer(
          polylines: [Polyline(points: widget.routePoints, color: Colors.blue, strokeWidth: 4)],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 40,
              height: 40,
              point: widget.start,
              child: const Icon(Icons.location_on, color: Colors.green, size: 40),
            ),
            Marker(
              width: 40,
              height: 40,
              point: widget.destination,
              child: const Icon(Icons.flag, color: Colors.red, size: 40),
            ),
          ],
        ),
      ],
    );
  }
}
