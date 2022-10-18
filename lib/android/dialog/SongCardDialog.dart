import 'package:autoscrollpdf/Helper/ParametersHelper.dart';
import 'package:autoscrollpdf/android/homepage/homepage.dart';
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
  String preferencesKey = "";
  SongCardDialog({Key? key, required this.song}) : super(key: key);

  @override
  State<SongCardDialog> createState() => _SongCardDialogState();
}

class _SongCardDialogState extends State<SongCardDialog> {
  @override
  void initState() {
    widget.preferencesKey = widget.song.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.5,
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle, color: Constants.primaryColor),
          child: Column(
            children: [
              _centerTitleText(widget.song.title),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _saveButton(widget.title, widget.duration, widget.offset,
                      widget.tags),
                  _deleteSongButton(),
                  //const Spacer(),
                  _cancelButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Center _centerTitleText(String title) {
    return Center(
      child: Text(
        title,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: const TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500),
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
          style: ElevatedButton.styleFrom(
            primary: Constants.secondaryColor,
          ),
          label: const Text("Aggiungi tag"),
          icon: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            _showAddTagDialog(context, widget.song.tags);
          },
        )
      ],
    );
  }

  IconButton _cancelButton() {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
        iconSize: 35,
        onPressed: () {
          print(widget.title);
          print(widget.duration);
          print(widget.offset);
          print(widget.tags);
          Navigator.pop(context);
        });
  }

  IconButton _saveButton(
      String title, int duration, double offset, List<String> tags) {
    return IconButton(
        color: Colors.black,
        iconSize: 35,
        onPressed: () {
          _saveSong();
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
            return const HomePageAndroid();
          }));
        },
        icon: const Icon(Icons.save));
  }

  IconButton _deleteSongButton() {
    return IconButton(
      onPressed: () {
        ParametersHelper.delete(widget.preferencesKey);
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return const HomePageAndroid();
        }));
      },
      icon: const Icon(Icons.delete),
      color: Colors.black,
      iconSize: 35,
    );
  }

  void _saveSong() {
    if (widget.title != widget.song.title) {
      widget.song.addTitle(widget.title);
    }
    if (widget.duration != widget.song.duration) {
      widget.song.setDuration(widget.duration);
    }
    if (widget.offset != widget.song.offset) {
      widget.song.setOffset(widget.offset);
    }
    //da finire il caso della lista di tag
    if (widget.tags.isNotEmpty) {
      widget.song.addTag(widget.tags);
    }
    ParametersHelper.saveSong(widget.song);
    ParametersHelper.delete(widget.preferencesKey);
  }

  _showAddTagDialog(BuildContext context, List<String> selectedTags) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Aggiungi tag"),
            content: MultiSelect(
              selectedTags: selectedTags,
            ),
          );
        });
  }
}
