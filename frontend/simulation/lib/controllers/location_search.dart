import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/location_search.dart';

class LocationSearchController {
  final TextEditingController textController;
  final ValueNotifier<List<LocationSearchModel>> suggestions = ValueNotifier([]);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Timer? _debounce;
  bool _suppressListener = false;

  LocationSearchController({required this.textController}) {
    textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_suppressListener) return;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      fetchSuggestions(textController.text);
    });
  }

  Future<void> fetchSuggestions(String query) async {
    if (query.isEmpty) {
      suggestions.value = [];
      return;
    }

    isLoading.value = true;

    try {
      final url = 'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&addressdetails=1&limit=5&accept-language=ko';
      final response = await http.get(Uri.parse(url), headers: {'User-Agent': 'Flutter App'});
      final data = json.decode(response.body) as List;

      if (query == textController.text) {
        suggestions.value = data.map((e) => LocationSearchModel.fromJson(e as Map<String, dynamic>)).toList();
      }
    } catch (_) {
      suggestions.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  void selectSuggestion(LocationSearchModel suggestion) {
    _suppressListener = true;
    textController.text = suggestion.displayName;
    suggestions.value = [];
    _suppressListener = false;

    // Optional: update map coordinates
    // mapController.updatePosition(LatLng(suggestion.lat, suggestion.lon));
  }

  void dispose() {
    textController.dispose();
    suggestions.dispose();
    isLoading.dispose();
    _debounce?.cancel();
  }
}
