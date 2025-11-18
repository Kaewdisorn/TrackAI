import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteMap extends StatefulWidget {
  final LatLng? start;
  final LatLng? destination;
  final ValueNotifier<List<LatLng>> routePointsNotifier;

  const RouteMap({super.key, this.start, this.destination, required this.routePointsNotifier});

  @override
  RouteMapState createState() => RouteMapState();
}

class RouteMapState extends State<RouteMap> {
  late final MapController mapController;
  LatLng? currentPosition;
  Timer? _timer;
  int _currentStep = 0;
  double currentZoom = 15.0;
  final double speedMetersPerSec = 5.0;

  bool isPaused = false;
  final Distance distance = Distance();
  final initLatLng = LatLng(37.5665, 126.9780); // Default to Seoul

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    currentPosition = widget.start ?? initLatLng;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(currentPosition!, currentZoom);
    });

    widget.routePointsNotifier.addListener(() {
      setState(() {});
    });
  }

  void startSimulation(List<LatLng> routePoints) {
    _currentStep = 0;
    _timer?.cancel();
    const interval = Duration(milliseconds: 100);

    _timer = Timer.periodic(interval, (_) {
      if (isPaused) return; // skip movement if paused

      if (_currentStep >= routePoints.length - 1) {
        _timer?.cancel();
        return;
      }

      final from = routePoints[_currentStep];
      final to = routePoints[_currentStep + 1];

      const double fractionPerStep = 0.02;
      setState(() {
        currentPosition = LatLng(
          currentPosition!.latitude + (to.latitude - from.latitude) * fractionPerStep,
          currentPosition!.longitude + (to.longitude - from.longitude) * fractionPerStep,
        );
      });

      // Check if we reached "to" point
      if ((currentPosition!.latitude - from.latitude).abs() >= (to.latitude - from.latitude).abs() &&
          (currentPosition!.longitude - from.longitude).abs() >= (to.longitude - from.longitude).abs()) {
        currentPosition = to;
        _currentStep++;
      }
    });
  }

  void pauseSimulation() {
    setState(() => isPaused = true);
  }

  void resumeSimulation() {
    setState(() => isPaused = false);
  }

  void resetSimulation() {
    _timer?.cancel(); // stop movement
    _currentStep = 0; // reset step counter
    isPaused = false; // clear pause flag

    // Reset current position to start point or default
    setState(() {
      currentPosition = widget.start ?? initLatLng;
    });

    // Move map to start position
    mapController.move(currentPosition!, currentZoom);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routePoints = widget.routePointsNotifier.value;

    List<Marker> markers = [];
    if (widget.start != null) {
      markers.add(
        Marker(
          width: 40,
          height: 40,
          point: widget.start!,
          child: const Icon(Icons.location_on, color: Colors.green, size: 40),
        ),
      );
    }
    if (widget.destination != null) {
      markers.add(
        Marker(
          width: 40,
          height: 40,
          point: widget.destination!,
          child: const Icon(Icons.flag, color: Colors.red, size: 40),
        ),
      );
    }
    if (currentPosition != null) {
      markers.add(
        Marker(
          width: 40,
          height: 40,
          point: currentPosition!,
          child: const Icon(Icons.directions_car, color: Colors.orange, size: 40),
        ),
      );
    }

    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(initialCenter: currentPosition ?? LatLng(37.5665, 126.9780), initialZoom: currentZoom, minZoom: 3, maxZoom: 18),
          children: [
            TileLayer(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: const ['a', 'b', 'c']),
            if (routePoints.isNotEmpty)
              PolylineLayer(
                polylines: [Polyline(points: routePoints, color: Colors.blue, strokeWidth: 4)],
              ),
            MarkerLayer(markers: markers),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: Column(
            children: [
              FloatingActionButton(
                heroTag: "moveToCurrent",
                mini: true,
                backgroundColor: Colors.blue,
                onPressed: () {
                  if (currentPosition != null) {
                    mapController.move(currentPosition!, currentZoom);
                  }
                },
                child: const Icon(Icons.my_location, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
