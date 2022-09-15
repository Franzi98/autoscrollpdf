import 'dart:io';

import 'package:autoscrollpdf/Classes/Song.dart';
import 'package:autoscrollpdf/Helper/ParametersHelper.dart';
import 'package:autoscrollpdf/android/pdf_activity/PdfActivity.dart';
import 'package:autoscrollpdf/utily/Constants.dart';
import 'package:autoscrollpdf/Helper/Functions.dart';
import 'package:autoscrollpdf/utily/tags.dart';
import 'package:autoscrollpdf/widget/SongCard.dart';
import 'package:autoscrollpdf/widget/folder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePageAndroid extends StatelessWidget {
  const HomePageAndroid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = ParametersHelper.getKeys().toString();
    return Scaffold(
      floatingActionButton: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          _floatingActionButtonOnline(context),
          const Spacer(),
          _floatingActionButtonLocal(context)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _makeImage(),
            _makeFolderCard(),

            SingleChildScrollView(
                child: _makeGridView(ParametersHelper.getSongs(), context)),
            //Divider(),
            //Padding(
            //  padding: const EdgeInsets.all(15),
            //  child: Text(text),
            //),
            Text(Constants.version)
          ],
        ),
      ),
    );
  }

  /*
  output: griglia se song.lenght > 2
          Riga se songs.length < 2
          Text se song.isEmpty(); 
  */
  Widget _makeGridView(List<Song> songs, BuildContext context) {
    if (songs.isEmpty) {
      return const Text("Non ci sono brani da visualizzare");
    } else if (songs.length <= 2) {
      if (songs.length == 1) {
        return SongCard(song: songs[0]);
      } else {
        return Row(
          children: [SongCard(song: songs[0]), SongCard(song: songs[1])],
        );
      }
    } else {
      return SingleChildScrollView(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 3),
            itemBuilder: (context, index) {
              return SongCard(song: songs[index]);
            }),
      );
    }
  }

  FloatingActionButton _floatingActionButtonOnline(BuildContext context) {
    return FloatingActionButton(
      heroTag: "btn1",
      child: const Icon(Icons.wordpress),
      onPressed: () {
        showDialog(
            context: context,
            builder: (builder) {
              return _dialogInsertURL(context);
            });
      },
    );
  }

  FloatingActionButton _floatingActionButtonLocal(BuildContext context) {
    return FloatingActionButton(
      heroTag: "btn2",
      child: const Icon(Icons.picture_as_pdf),
      onPressed: () async {
        Song song = await _pickFile();
        if (!Functions.existsKey(
            Functions.makeTitle(song.path), ParametersHelper.getKeys())) {
          showDialog(
              context: context,
              builder: (context) {
                return _dialogSaveFile(context, song);
              });
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return PdfActivityAndroid(song: song);
          }));
        }
      },
    );
  }

  Image _makeImage() {
    return Image.asset("lib/assets/AutoScrollPDF_Logo.PNG");
  }

  dynamic _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
    if (result != null) {
      File file = File(result.files.single.path!);
      return Song(
        path: file.path,
      );
    }
  }

  AlertDialog _dialogSaveFile(BuildContext context, Song song) {
    return AlertDialog(
      title: const Text("Vuoi salvare il file?"),
      content: const Text("Il file sembra essere nuovo, scegli cosa vuoi fare"),
      actions: [
        ElevatedButton.icon(
            onPressed: () {
              ParametersHelper.saveSong(song);
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                return PdfActivityAndroid(song: song);
              }));
            },
            icon: const Icon(Icons.save),
            label: const Text("Salva")),
        ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
            label: const Text("Scarta e Chiudi")),
        ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                return PdfActivityAndroid(song: song);
              }));
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text("Scarta e visualizza"))
      ],
    );
  }

  /*
  Dialog per inserire url 
  */
  AlertDialog _dialogInsertURL(BuildContext context) {
    String url;
    return AlertDialog(
      title: const Text("Inserisci URL file pdf"),
      content: TextFormField(
        decoration: const InputDecoration(hintText: "inserisciURL"),
        onChanged: (value) {
          url = value;
        },
      ),
      actions: [
        ElevatedButton(onPressed: () {}, child: const Text("Apri")),
        ElevatedButton(onPressed: () {}, child: const Text("Chiudi"))
      ],
    );
  }

  /*
  Crea la griglia delle cartelle 
  */
  _makeFolderCard() {
    return AspectRatio(
        aspectRatio: 1.3,
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          children: [
            FolderCard(
              img: Image.asset("lib/assets/dance.jpg"),
              tag: TAGS.dance,
            ),
            FolderCard(
              img: Image.asset("lib/assets/indie.jpg"),
              tag: TAGS.indie,
            ),
            FolderCard(
              img: Image.asset("lib/assets/pop.png"),
              tag: TAGS.pop,
            ),
            FolderCard(
              img: Image.asset("lib/assets/rock.jpg"),
              tag: TAGS.rock,
            ),
            FolderCard(
                img: Image.asset("lib/assets/other.png"), tag: TAGS.notag)
          ],
        ));
  }
}
