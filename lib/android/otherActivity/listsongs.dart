import 'package:autoscrollpdf/Classes/Song.dart';
import 'package:autoscrollpdf/Helper/Functions.dart';
import 'package:autoscrollpdf/Helper/ParametersHelper.dart';
import 'package:autoscrollpdf/utily/Constants.dart';
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
    return Scaffold(
      floatingActionButton: _actionButton(context),
      body: SafeArea(
        child: Column(
          children: [
            _makeImage(context),
            Flexible(child: _makeContent(songs)),
          ],
        ),
      ),
    );
  }

  //out: lista con le canzoni del tag scelto
  List<Song> _getTagSongs() {
    List<Song> lists = ParametersHelper.getSongs();
    List<Song> selectedList = [];
    for (int i = 0; i <= lists.length - 1; i++) {
      if (lists[i].tags.contains(Functions.tagToString(tag))) {
        selectedList.add(lists[i]);
      }
    }
    return selectedList;
  }

  Container _makeImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Constants.primaryColor,
          image: DecorationImage(image: img.image, fit: BoxFit.fill)),
    );
  }

  Widget _makeContent(List<Song> songs) {
    if (songs.isNotEmpty) {
      return ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Constants.primaryColor,
              padding: const EdgeInsets.all(5),
              child: SongTile(song: songs[index]));
        },
      );
    } else {
      return const Center(
        child: Text("Non ci sono brani da visualizzare"),
      );
    }
  }

  FloatingActionButton _actionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: (() => Navigator.pop(context)),
      child: const Icon(Icons.arrow_back),
    );
  }
}
