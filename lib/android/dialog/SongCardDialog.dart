import 'package:autoscrollpdf/utily/Constants.dart';
import 'package:autoscrollpdf/utily/tags.dart';
import 'package:autoscrollpdf/widget/multiselect.dart';
import 'package:flutter/material.dart';

import '../../Classes/Song.dart';
import '../../widget/TagsCard.dart';

class SongCardDialog extends StatefulWidget {
  Song song;
  String title = "";
  List<String> tags = [];
  int duration = 0;
  double offset = 0;
  SongCardDialog({Key? key, required this.song}) : super(key: key);

  @override
  State<SongCardDialog> createState() => _SongCardDialogState();
}

class _SongCardDialogState extends State<SongCardDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Column(
          children: [
            _titleTextField(),
            const SizedBox(
              height: 10,
            ),
            _durationTextField(),
            const SizedBox(
              height: 10,
            ),
            _offsetTextField(),
            const SizedBox(
              height: 10,
            ),
            _tagsGridView(context),
            const Spacer(),
            Row(
              children: [
                _saveButton(),
                const Spacer(),
                _cancelButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField _offsetTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: widget.song.offset.toString(),
          labelText: Constants.offset,
          icon: const Icon(
            Icons.width_full,
            color: Colors.red,
          )),
      onChanged: (value) {
        setState(() {
          widget.offset = double.parse(value);
        });
      },
    );
  }

  TextFormField _durationTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: widget.song.duration.toString(),
        labelText: Constants.duration,
        icon: const Icon(
          Icons.timer,
          color: Colors.red,
        ),
      ),
      onChanged: (value) {
        widget.duration = double.parse(value).round();
      },
    );
  }

  TextFormField _titleTextField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: widget.song.title,
          labelText: "Titolo",
          icon: const Icon(
            Icons.title,
            color: Colors.red,
          )),
      onChanged: (value) {
        setState(() {
          widget.title = value;
        });
      },
    );
  }

  Widget _tagsGridView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Center(
          child: Text(
            "Tags: ",
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GridView.count(
          mainAxisSpacing: 3,
          crossAxisSpacing: 8,
          shrinkWrap: true,
          crossAxisCount: 5,
          children: List.generate(widget.tags.length, (index) {
            return TagsCard(
              tag: widget.song.getTagsAsString[index],
              song: widget.song,
            );
          }),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton.icon(
          label: const Text("Aggiungi tag"),
          icon: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            _showAddTagDialog(context);
          },
        )
      ],
    );
  }

  ElevatedButton _cancelButton() {
    return ElevatedButton.icon(
        onPressed: () {
          print(widget.title);
          print(widget.duration);
          print(widget.offset);
          print(widget.tags);
        },
        icon: const Icon(Icons.delete),
        label: const Text("Cancella"));
  }

  ElevatedButton _saveButton() {
    return ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.save),
        label: const Text("Salva"));
  }

  _showAddTagDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Aggiungi tag"),
            content: MultiSelect(),
          );
        });
  }
}
