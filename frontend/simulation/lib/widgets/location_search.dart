import 'package:flutter/material.dart';
import '../controllers/location_search.dart';
import '../models/location_search.dart';

class LocationSearch extends StatefulWidget {
  final LocationSearchController textfieldController;
  final String labelText;

  const LocationSearch({super.key, required this.textfieldController, required this.labelText});

  @override
  LocationSearchState createState() => LocationSearchState();
}

class LocationSearchState extends State<LocationSearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: widget.textfieldController.isLoading,
          builder: (context, loading, _) {
            return TextField(
              controller: widget.textfieldController.textController,
              decoration: InputDecoration(labelText: widget.labelText, suffixIcon: loading ? const CircularProgressIndicator() : null),
            );
          },
        ),
        ValueListenableBuilder<List<LocationSearchModel>>(
          valueListenable: widget.textfieldController.suggestions,
          builder: (context, suggestions, _) {
            if (suggestions.isEmpty) return const SizedBox.shrink();
            return Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return ListTile(title: Text(suggestion.displayName), onTap: () => widget.textfieldController.selectSuggestion(suggestion));
                },
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.textfieldController.dispose();
    super.dispose();
  }
}
