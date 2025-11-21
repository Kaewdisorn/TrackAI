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
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _showOverlay() {
    _overlayEntry?.remove();
    if (!_focusNode.hasFocus || _results.value.isEmpty) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 4,
        width: size.width,
        child: Material(
          elevation: 4,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _results,
              builder: (context, list, _) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final option = list[index];
                    return ListTile(
                      title: Text(option),
                      onTap: () {
                        widget.textfieldController.text = option;
                        _results.value = [];
                        _overlayEntry?.remove();
                        _focusNode.unfocus();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _overlayEntry?.remove();
      } else {
        _showOverlay();
      }
    });

    _results.addListener(() {
      _showOverlay();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: widget.textfieldController,
        focusNode: _focusNode,
        decoration: InputDecoration(labelText: widget.labelText, border: const OutlineInputBorder()),
        onChanged: (value) {
          locationSearchController.search(value, (results) {
            _results.value = results;
          });
        },
      ),
    );
  }
}
