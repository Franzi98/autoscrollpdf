import 'package:flutter/material.dart';

import '../Classes/Song.dart';

class TagsCard extends StatelessWidget {
  String tag;
  Song song;
  TagsCard({Key? key, required this.tag, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 1.5),
      ),
      width: 250,
      height: 100,
      child: InkWell(
        onLongPress: () =>
            ScaffoldMessenger.of(context).showSnackBar(_deleteSnackBar(song)),
        child: Center(
          child: Text(
            "#$tag",
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }

  SnackBar _deleteSnackBar(Song song) {
    song.removeTag(tag);
    return SnackBar(
      content: const Text("Tag eliminato"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            song.addTag(tag);
          }),
    );
  }
}
