import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationSearchController {
  final TextEditingController textController;
  final ValueNotifier<List<String>> suggestions = ValueNotifier([]);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool _suppressListener = false;

  LocationSearchController({required this.textController}) {
    textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_suppressListener) return; // 🔹 prevent loop
    fetchSuggestions(textController.text);
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

      suggestions.value = data.map((e) => e['display_name'] as String).toList();
    } catch (_) {
      suggestions.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  void selectSuggestion(String suggestion) {
    _suppressListener = true; // 🔹 suppress listener
    textController.text = suggestion;
    suggestions.value = [];
    _suppressListener = false; // 🔹 restore listener
  }

  void dispose() {
    textController.dispose();
    suggestions.dispose();
    isLoading.dispose();
  }
}
