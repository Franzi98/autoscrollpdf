import 'package:autoscrollpdf/android/pdf_activity/PdfActivity.dart';
import 'package:flutter/material.dart';

import '../Classes/Song.dart';

class SongTile extends StatelessWidget {
  Song song;
  SongTile({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PdfActivityAndroid(song: song);
        })),
        child: ListTile(
          leading: FlutterLogo(),
          title: Text(song.title),
          subtitle: Text(song.path),
        ),
      ),
    );
  }
}
