import 'package:autoscrollpdf/utily/tags.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class MultiSelect extends StatefulWidget {
  MultiSelect({Key? key}) : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  List<TAGS> selectedTags = [];
  List<TAGS> tags = TAGS.values;
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
    return ChipsChoice<TAGS>.multiple(
        value: selectedTags,
        onChanged: (val) {
          setState(() {
            selectedTags = val;
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
