import 'package:bb_mobile/_ui/components/chip_input.dart';
import 'package:bb_mobile/_ui/components/text.dart';
import 'package:bb_mobile/styles.dart';
import 'package:flutter/material.dart';

class LabelField extends StatefulWidget {
  const LabelField({super.key, required this.suggestions, required this.onChanged, this.labels});

  final List<String> suggestions;
  final Function onChanged;
  final List<String>? labels;

  @override
  LabelFieldState createState() {
    return LabelFieldState();
  }
}

class LabelFieldState extends State<LabelField> {
  final FocusNode _chipFocusNode = FocusNode();
  late List<String> _labels = <String>[];
  late String _searchQuery = '';
  List<String> _suggestions = <String>[];

  @override
  void initState() {
    super.initState();
    _labels = widget.labels != null ? List<String>.from(widget.labels!) : [];
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: context.colour.onBackground.withOpacity(0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: context.colour.onBackground,
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        ChipsInput<String>(
          values: _labels,
          strutStyle: const StrutStyle(fontSize: 15),
          onChanged: _onChanged,
          onSubmitted: _onSubmitted,
          chipBuilder: _chipBuilder,
          onTextChanged: _onSearchChanged,
          decoration: inputDecoration,
        ),
        if (_suggestions.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 10, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colour.background,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _suggestions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LabelSuggestion(
                      _suggestions[index],
                      onTap: _selectSuggestion,
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _onSearchChanged(String value) async {
    final List<String> results = await _suggestionCallback(value);
    setState(() {
      _suggestions = results.where((String label) => !_labels.contains(label)).toList();
      _searchQuery = value;
    });
  }

  Widget _chipBuilder(BuildContext context, String label) {
    return LabelInputChip(
      label: label,
      onDeleted: _onChipDeleted,
      onSelected: _onChipTapped,
    );
  }

  void _selectSuggestion(String label) {
    // print('Suggestion selected: $label');
    setState(() {
      _labels.add(label);
      _suggestions = <String>[];
    });
    widget.onChanged(_labels);
  }

  void _onChipTapped(String label) {
    // print('Chip tapped: $label');
  }

  void _onChipDeleted(String label) {
    // print('Chip deleted: $label');
    setState(() {
      _labels.remove(label);
      _suggestions = <String>[];
    });
    widget.onChanged(_labels);
  }

  void _onSubmitted(String text) {
    print('Submitted: $text');
    if (text.trim().isNotEmpty && !_labels.contains(text.trim())) {
      setState(() {
        _labels = <String>[..._labels, text.trim()];
      });
    } else {
      _chipFocusNode.unfocus();
      setState(() {
        _suggestions = <String>[];
      });
    }
    widget.onChanged(_labels);
  }

  void _onChanged(List<String> data) {
    // print('Changed: $data');
    setState(() {
      _labels = data;
    });
  }

  Future<List<String>> _suggestionCallback(String text) async {
    if (text.isNotEmpty) {
      return widget.suggestions.where((String label) {
        return label.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return const <String>[];
  }
}

class LabelSuggestion extends StatelessWidget {
  const LabelSuggestion(this.label, {super.key, this.onTap});

  final String label;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ObjectKey(label),
      title: BBText.body(label),
      onTap: () => onTap?.call(label),
    );
  }
}

class LabelInputChip extends StatelessWidget {
  const LabelInputChip({
    super.key,
    required this.label,
    required this.onDeleted,
    required this.onSelected,
  });

  final String label;
  final ValueChanged<String> onDeleted;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: InputChip(
        key: ObjectKey(label),
        label: BBText.body(label),
        onDeleted: () => onDeleted(label),
        onSelected: (bool value) => onSelected(label),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        deleteIconColor: context.colour.surface,
        padding: const EdgeInsets.all(2),
        backgroundColor: context.colour.background,
        selectedColor: Colors.blue,
        shape: StadiumBorder(
          side: BorderSide(color: context.colour.surface.withOpacity(0.2), strokeAlign: 0),
        ),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(2.0)),
        //   side: BorderSide(color: Colors.red, width: 1.5),
        // ),
      ),
    );
  }
}
