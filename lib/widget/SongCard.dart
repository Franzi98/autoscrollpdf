import 'dart:io';

import 'package:autoscrollpdf/android/pdf_activity/PdfActivity.dart';
import 'package:autoscrollpdf/widget/SongCardDialog.dart';
import 'package:flutter/material.dart';

import '../Classes/Song.dart';

class SongCard extends StatelessWidget {
  Song song;

  SongCard({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double altezza = MediaQuery.of(context).size.height;
    //double larghezza = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(
            color: Colors.black,
            width: 2,
          )),
      color: Colors.white,
      shadowColor: const Color.fromARGB(255, 0, 0, 0),
      child: InkWell(
        onTap: (() {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return PdfActivityAndroid(song: song);
          }));
        }),
        onLongPress: () {
          showDialog(
              context: context,
              builder: (builder) {
                return SongCardDialog(song: song);
              });
        },
        splashColor: Colors.blue.withAlpha(30),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              Center(
                child: Text(
                  _makeTitle(song.title),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Text("#${song.tags.toString()}"),
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }

  String _makeTitle(String title) {
    if (title.length > 10) {
      return "${title.substring(0, 10)}...";
    } else {
      return title;
    }
  }
}
