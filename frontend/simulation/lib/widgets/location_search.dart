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
  final locationSearchController = LocationSearchController();
  final ValueNotifier<List<String>> _results = ValueNotifier([]);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // rebuild dropdown visibility
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.textfieldController, // use external controller directly
          focusNode: _focusNode,
          decoration: InputDecoration(labelText: widget.labelText, border: const OutlineInputBorder()),
          onChanged: (value) {
            locationSearchController.search(value, (results) {
              _results.value = results;
            });
          },
        ),
        ValueListenableBuilder<List<String>>(
          valueListenable: _results,
          builder: (context, list, _) {
            if (!_focusNode.hasFocus || list.isEmpty) return const SizedBox.shrink();

            final height = list.length > 5 ? 200.0 : list.length * 50.0;

            return Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              height: height,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final option = list[index];
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      widget.textfieldController.text = option;
                      _results.value = [];
                      _focusNode.unfocus();
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
