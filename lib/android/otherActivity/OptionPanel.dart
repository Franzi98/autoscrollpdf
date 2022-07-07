import 'package:autoscrollpdf/Helper/ParametersHelper.dart';
import 'package:autoscrollpdf/android/pdf_activity/PdfActivity.dart';
import 'package:flutter/material.dart';

class OptionPanel extends StatefulWidget {
  String path;
  bool isOnline;
  OptionPanel({Key? key, required this.path, required this.isOnline})
      : super(key: key);

  @override
  State<OptionPanel> createState() => _OptionPanelState();
}

class _OptionPanelState extends State<OptionPanel> {
  String offset = "";
  String duration = "";
  int cronologia = 0;
  @override
  void initState() {
    super.initState();
    duration = ParametersHelper.getDuration().toString();
    offset = ParametersHelper.getOffset().toString();
  }

  Future _saveData(String key, double x) {
    if (key == "Duration") {
      setState(() {
        duration = x.toString();
      });
      return ParametersHelper.setDuration(x.toInt());
    } else if (key == "Offset") {
      setState(() {
        offset = x.toString();
      });
      return ParametersHelper.setOffset(x);
    } else {
      setState(() {
        cronologia = x.toInt();
      });
      return ParametersHelper.setListLength(x.toInt());
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PdfActivityAndroid(
                              path: widget.path, onlineAssets: widget.isOnline);
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
        openDialog(context, "Offset");
      },
    );
  }

  ListTile _makeTileHistory(BuildContext context, int cronologia) {
    return ListTile(
      leading: const Icon(
        Icons.history,
        color: Colors.white,
      ),
      title: const Text("Cronologia Documenti"),
      subtitle: const Text("Funzione non abilitata"),
      onTap: () => openDialog(context, "Cronologia"),
    );
  }

  String? _makeHintText(String key) {
    if (key == "Duration") {
      return "Inserisci intervallo di scorrimento";
    } else if (key == "Offset") {
      return "Inserisci offset di scorrimento";
    } else if (key == "Cronologia") {
      return "Inserisci numero di file da visualizzare";
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
          _makeTileHistory(context, cronologia)
        ],
      ),
    ));
  }
}
