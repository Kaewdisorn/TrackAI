import 'package:flutter/material.dart';

class LocationSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final List<String> options;

  /// A reusable Location Search Field
  /// [controller]: the TextEditingController to read/write value
  /// [labelText]: text shown in the TextField label
  /// [options]: list of autocomplete suggestions (can be replaced with API later)
  const LocationSearchField({super.key, required this.controller, required this.labelText, required this.options});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
        return options.where((option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (selection) {
        controller.text = selection;
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        // Sync internal controller with external
        textEditingController.addListener(() {
          controller.text = textEditingController.text;
        });

        controller.addListener(() {
          // to avoid unnecessary rebuilds, only update if different
          if (controller.text != textEditingController.text) {
            textEditingController.text = controller.text;
          }
        });

        return TextField(
          controller: textEditingController, // <-- use internal controller
          focusNode: focusNode,
          decoration: InputDecoration(labelText: labelText, border: const OutlineInputBorder()),
        );
      },
    );
  }
}
