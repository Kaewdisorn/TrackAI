import 'package:flutter/material.dart';
import '../controllers/location_search.dart';

class LocationSearch extends StatefulWidget {
  final TextEditingController textfieldController;
  final String labelText;

  const LocationSearch({super.key, required this.textfieldController, required this.labelText});

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  final ValueNotifier<List<String>> _results = ValueNotifier([]);
  final locationSearchController = LocationSearchController();

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (value) {
        locationSearchController.search(value.text, (list) {
          _results.value = list;
        });

        if (value.text.isEmpty) return const Iterable.empty();
        return _results.value;
      },

      optionsViewBuilder: (context, onSelected, options) {
        return ValueListenableBuilder<List<String>>(
          valueListenable: _results,
          builder: (context, updatedOptions, child) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: updatedOptions.length,
                    itemBuilder: (context, index) {
                      final option = updatedOptions[index];
                      return ListTile(title: Text(option), onTap: () => onSelected(option));
                    },
                  ),
                ),
              ),
            );
          },
        );
      },

      onSelected: (selection) {
        widget.textfieldController.text = selection;
      },

      fieldViewBuilder: (context, textController, focusNode, _) {
        textController.addListener(() {
          widget.textfieldController.text = textController.text;
        });

        return TextField(
          controller: textController,
          focusNode: focusNode,
          decoration: InputDecoration(labelText: widget.labelText, border: const OutlineInputBorder()),
        );
      },
    );
  }
}
