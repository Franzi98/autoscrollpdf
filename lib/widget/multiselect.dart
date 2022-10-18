import 'package:autoscrollpdf/utily/tags.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import '../Helper/Functions.dart';

class MultiSelect extends StatefulWidget {
  List<String> selectedTags;
  MultiSelect({Key? key, required this.selectedTags}) : super(key: key);

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
              children: [
                ElevatedButton.icon(
                    onPressed: (() => Navigator.pop(context)),
                    icon: const Icon(Icons.delete),
                    label: const Text("Cancella")),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.save),
                    label: const Text("Salva"))
              ],
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
}
