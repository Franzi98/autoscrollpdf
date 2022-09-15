import 'package:autoscrollpdf/Classes/Song.dart';
import 'package:autoscrollpdf/Helper/ParametersHelper.dart';
import 'package:autoscrollpdf/utily/tags.dart';
import 'package:autoscrollpdf/widget/songtile.dart';
import 'package:flutter/material.dart';

class ListSongs extends StatelessWidget {
  TAGS tag;
  Image img;
  ListSongs({Key? key, required this.tag, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Song> songs = _getTagSongs();
    return SafeArea(
      child: Row(
        children: [
          Image(image: img.image),
          ListView.builder(itemBuilder: ((context, index) {
            return SongTile(song: songs[index]);
          }))
        ],
      ),
    );
  }

  //out: lista con le canzoni del tag scelto
  List<Song> _getTagSongs() {
    List<Song> lists = [];
    ParametersHelper.getSongs().forEach((element) {
      if (element.tags.contains(tag.toString())) {
        lists.add(element);
      }
    });
    return lists;
  }
}
