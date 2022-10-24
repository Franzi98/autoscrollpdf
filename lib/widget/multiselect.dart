import 'package:autoscrollpdf/utily/tags.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import '../Helper/Functions.dart';

class MultiSelect extends StatefulWidget {
  List<String> selectedTags;
  void Function(List<String>) onSaveButton;
  MultiSelect({
    Key? key,
    required this.selectedTags,
    required this.onSaveButton,
  }) : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  List<String> tags = Functions.listTagsToListString(TAGS.values);

  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _makeChipsChoices(),
            Row(
              children: [_cancelButton(), const Spacer(), _saveButton()],
            )
          ],
        ));
  }

  ChipsChoice _makeChipsChoices() {
    return ChipsChoice<String>.multiple(
        value: widget.selectedTags,
        onChanged: (val) {
          setState(() {
            widget.selectedTags = val;
          });
        },
        choiceItems: C2Choice.listFrom(
            source: tags,
            value: (i, v) {
              return tags[i];
            },
            label: (i, v) => v.toString()));
  }

  ElevatedButton _saveButton() {
    return ElevatedButton.icon(
        onPressed: () {
          widget.onSaveButton(widget.selectedTags);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.save),
        label: const Text("Salva"));
  }

  ElevatedButton _cancelButton() {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.cancel),
        label: const Text("Cancella"));
  }
}
