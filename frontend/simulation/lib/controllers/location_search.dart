import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationSearchController {
  Timer? _debounce;

  void search(String query, Function(List<String>) onResult) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (query.isEmpty) {
        onResult([]);
        return;
      }

      final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5');

      final response = await http.get(url, headers: {'User-Agent': 'FlutterApp/1.0 (email@example.com)'});

      if (response.statusCode == 200) {
        final list = jsonDecode(response.body) as List;
        final results = list.map((e) => e['display_name'] as String).toList();
        onResult(results);
      }
    });
  }
}
