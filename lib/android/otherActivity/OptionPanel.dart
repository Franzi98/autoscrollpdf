import 'package:autoscrollpdf/Classes/Song.dart';
import 'package:autoscrollpdf/Helper/Functions.dart';
import 'package:autoscrollpdf/Helper/ParametersHelper.dart';
import 'package:autoscrollpdf/android/pdf_activity/PdfActivity.dart';
import 'package:flutter/material.dart';

class OptionPanel extends StatefulWidget {
  Song song;
  OptionPanel({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  State<OptionPanel> createState() => _OptionPanelState();
}

class _OptionPanelState extends State<OptionPanel> {
  String offset = "";
  String duration = "";
  @override
  void initState() {
    super.initState();
    duration = widget.song.duration.toString();
    offset = widget.song.offset.toString();
  }

  void _saveData(String key, double x) {
    if (key == "Duration") {
      setState(() {
        duration = x.toString();
      });
      widget.song.setDuration(x.round());
    } else if (key == "Offset") {
      setState(() {
        offset = x.toString();
      });
      widget.song.setOffset(x);
    }
  }

  Future openDialog(
    BuildContext context,
    String key,
  ) {
    double _input = 0;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.all(5),
              child: AlertDialog(
                title: const Text("Inserisci valore"),
                content: TextField(
                    onChanged: (value) {
                      _input = double.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: _makeHintText(key))),
                actions: [
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    label: const Text("Cancella"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        _saveData(key, _input);
                        ParametersHelper.delete(
                            Functions.makeTitle(widget.song.path));
                        ParametersHelper.saveSong(widget.song);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PdfActivityAndroid(
                            song: widget.song,
                          );
                        }));
                      },
                      icon: const Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: const Text("Salva"))
                ],
              ));
        });
  }

  ListTile _makeTileDuration(BuildContext context, String duration) {
    return ListTile(
      leading: const Icon(
        Icons.time_to_leave,
        color: Colors.white,
      ),
      title: const Text("Lentezza Scorrimento"),
      subtitle: Text(duration),
      onTap: () {
        openDialog(context, "Duration");
      },
    );
  }

  ListTile _makeTileOffset(BuildContext context, String offset) {
    return ListTile(
      leading: const Icon(
        Icons.airline_stops,
        color: Colors.white,
      ),
      title: const Text("Moltiplicatore Offset"),
      subtitle: Text(offset),
      onTap: () {
        openDialog(
          context,
          "Offset",
        );
      },
    );
  }

  ListTile _makeTileTags(BuildContext context, List tags) {
    return ListTile(
      leading: const Icon(
        Icons.tag,
        color: Colors.white,
      ),
      title: const Text("Tags"),
      subtitle: Text(tags.toString()),
      onTap: () {
        openDialog(context, "Tags");
      },
    );
  }

  String? _makeHintText(String key) {
    if (key == "Duration") {
      return "Inserisci intervallo di scorrimento";
    } else if (key == "Offset") {
      return "Inserisci offset di scorrimento";
    } else if (key == "Tags") {
      return "Inserisci tag";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          _makeTileDuration(context, duration),
          const Divider(
            color: Colors.black,
            thickness: 2,
          ),
          _makeTileOffset(context, offset),
          const Divider(
            color: Colors.black,
            thickness: 2,
          ),
          _makeTileTags(context, widget.song.tags)
        ],
      ),
    ));
  }
}
