import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteMap extends StatefulWidget {
  final LatLng? start;
  final LatLng? destination;
  final List<LatLng> routePoints;

  const RouteMap({super.key, this.start, this.destination, this.routePoints = const []});

  @override
  RouteMapState createState() => RouteMapState();
}

class RouteMapState extends State<RouteMap> {
  late final MapController _mapController;
  LatLng? currentPosition;
  Timer? _timer;
  int _currentStep = 0;
  double currentZoom = 15.0;

  final double speedMetersPerSec = 5.0;
  final Distance distance = Distance();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    currentPosition = widget.start ?? LatLng(37.5665, 126.9780);

    // Center map
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final centerLat = (widget.start?.latitude ?? currentPosition?.latitude ?? 37.5665);
      final centerLng = (widget.start?.longitude ?? currentPosition?.longitude ?? 126.9780);
      _mapController.move(LatLng(centerLat, centerLng), 15.0);
    });
  }

  void startSimulation() {
    if (widget.routePoints.isEmpty) return;

    _currentStep = 0;
    Duration interval = const Duration(milliseconds: 50);

    _timer = Timer.periodic(interval, (_) {
      if (_currentStep >= widget.routePoints.length - 1) {
        _timer?.cancel();
        return;
      }

      LatLng from = widget.routePoints[_currentStep];
      LatLng to = widget.routePoints[_currentStep + 1];

      double segmentDistance = distance.as(LengthUnit.Meter, from, to);
      int steps = (segmentDistance / (speedMetersPerSec * interval.inSeconds)).ceil();

      double latStep = (to.latitude - from.latitude) / steps;
      double lngStep = (to.longitude - from.longitude) / steps;

      int stepCounter = 0;
      Timer.periodic(interval, (t) {
        if (stepCounter >= steps) {
          t.cancel();
          _currentStep++;
        } else {
          setState(() {
            currentPosition = LatLng(from.latitude + latStep * stepCounter, from.longitude + lngStep * stepCounter);
          });
          stepCounter++;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          mapController: _mapController,
          options: MapOptions(initialCenter: currentPosition ?? LatLng(37.5665, 126.9780), initialZoom: currentZoom, minZoom: 3, maxZoom: 18),
          children: [
            TileLayer(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: const ['a', 'b', 'c']),
            if (widget.routePoints.isNotEmpty)
              PolylineLayer(
                polylines: [Polyline(points: widget.routePoints, color: Colors.blue, strokeWidth: 4)],
              ),
            MarkerLayer(markers: markers),
          ],
        ),

        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            heroTag: "moveToCurrent",
            mini: true,
            backgroundColor: Colors.blue, // <- make button blue
            onPressed: () {
              if (currentPosition != null) {
                _mapController.move(currentPosition!, currentZoom);
              }
            },
            child: const Icon(Icons.my_location, color: Colors.white), // optional: white icon for contrast
          ),
        ),
      ],
    );
  }
}
