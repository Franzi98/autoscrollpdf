import 'package:autoscrollpdf/utily/Constants.dart';
import 'package:flutter/material.dart';

import '../Classes/Song.dart';
import 'TagsCard.dart';

class SongCardDialog extends StatefulWidget {
  Song song;
  SongCardDialog({Key? key, required this.song}) : super(key: key);

  @override
  State<SongCardDialog> createState() => _SongCardDialogState();
}

class _SongCardDialogState extends State<SongCardDialog> {
  @override
  Widget build(BuildContext context) {
    String title = "";
    int duration = 0;
    double offset = 0;
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Column(
          children: [
            _titleTextField(title),
            const SizedBox(
              height: 10,
            ),
            _durationTextField(duration),
            const SizedBox(
              height: 10,
            ),
            _offsetTextField(offset),
            const SizedBox(
              height: 10,
            ),
            _tagsGridView(["si", "no"], context),
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

  TextFormField _offsetTextField(double offset) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: widget.song.offset.toString(),
          labelText: Constants.offset,
          icon: const Icon(
            Icons.width_full,
            color: Colors.red,
          )),
    );
  }

  TextFormField _durationTextField(int duration) {
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
        duration = double.parse(value).round();
      },
    );
  }

  TextFormField _titleTextField(String title) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: widget.song.title,
          labelText: "Titolo",
          icon: const Icon(
            Icons.title,
            color: Colors.red,
          )),
      onChanged: (value) {
        title = value;
      },
    );
  }

  Widget _tagsGridView(List<String> tags, BuildContext context) {
    return Column(
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
          children: List.generate(tags.length, (index) {
            return TagsCard(
              tag: tags[index],
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
          onPressed: () {},
        )
      ],
    );
  }

  ElevatedButton _cancelButton() {
    return ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.delete),
        label: const Text("Cancella"));
  }

  ElevatedButton _saveButton() {
    return ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.save),
        label: const Text("Salva"));
  }
}
