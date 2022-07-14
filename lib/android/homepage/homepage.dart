import 'dart:io';

import 'package:autoscrollpdf/android/pdf_activity/PdfActivity.dart';
import 'package:autoscrollpdf/utily/Constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePageAndroid extends StatelessWidget {
  const HomePageAndroid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  _openDialog(context);
                },
                child: const Text("Online Document")),
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom, allowedExtensions: ['pdf']);
                  if (result != null) {
                    PlatformFile pFile = result.files.first;
                    File file = File(pFile.path!);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      print(pFile.name);
                      print(pFile.path);
                      return PdfActivityAndroid(
                          file: file, onlineAssets: false);
                    }));
                  }
                },
                child: const Text("Local Document")),
            const Spacer(),
            Center(
              child: Text(Constants.version),
            ),
          ],
        ),
      ),
    );
  }

  Future _openDialog(BuildContext context) {
    late String link;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Inserisci link pdf"),
            content: TextField(onChanged: ((value) => link = value)),
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
                    if (_checkLink(link)) {
                      //print(link);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PdfActivityAndroid(
                            file: link, onlineAssets: true);
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Il link non è un pdf"),
                        action: SnackBarAction(
                          label: "Chiudi",
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ));
                    }
                  },
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  label: const Text("Salva"))
            ],
          );
        });
  }

  bool _checkLink(String link) {
    String extension = link.substring(link.length - 4);
    if (extension == '.pdf') {
      return true;
    } else {
      return false;
    }
  }
}
