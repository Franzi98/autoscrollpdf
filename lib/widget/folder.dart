import 'package:autoscrollpdf/android/otherActivity/listsongs.dart';
import 'package:autoscrollpdf/utily/tags.dart';
import 'package:flutter/material.dart';

class FolderCard extends StatelessWidget {
  Image img;
  TAGS tag;
  FolderCard({Key? key, required this.img, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
          side: BorderSide(width: 3),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: InkWell(
        onTap: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (buider) {
          return ListSongs(tag: tag, img: img);
        })),
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 7,
          child: Image(image: img.image),
        ),
      ),
    );
  }
}
