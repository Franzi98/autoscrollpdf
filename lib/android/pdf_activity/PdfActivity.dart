import 'dart:ffi';
import 'dart:io';

import 'package:autoscrollpdf/Classes/Song.dart';
import 'package:autoscrollpdf/android/homepage/homepage.dart';
import 'package:autoscrollpdf/android/otherActivity/OptionPanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfActivityAndroid extends StatefulWidget {
  Song song;
  PdfActivityAndroid({Key? key, required this.song}) : super(key: key);

  @override
  State<PdfActivityAndroid> createState() => _PdfActivityAndroidState();
}

class _PdfActivityAndroidState extends State<PdfActivityAndroid> {
  bool isPlaying = false;
  late PdfViewerController _controller;
  late int duration;
  late double offset;
  @override
  void initState() {
    _controller = PdfViewerController();
    duration = widget.song.duration;
    offset = widget.song.offset;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const HomePageAndroid();
        }));
        return true;
        //return exit(0);
      },
      child: Scaffold(
          body: SafeArea(
              child: SfPdfViewer.file(
            widget.song.file,
            controller: _controller,
          )),
          floatingActionButton: _makeSpeedDial()),
    );
  }

  SpeedDial _makeSpeedDial() {
    return SpeedDial(
      heroTag: "btn1",
      renderOverlay: false,
      direction: SpeedDialDirection.left,
      children: [
        _makeFlaotingActionButtonSettings(),
        _makeFloatingActionButtonPlay(),
        _makeFloatingActionButtonZoomIn(),
        _makeFloatingActionButtonZoomOut(),
      ],
      child: const Icon(
        Icons.settings,
        color: Colors.black,
      ),
    );
  }

  SpeedDialChild _makeFloatingActionButtonPlay() {
    return SpeedDialChild(
      onTap: () async {
        setState(() {
          if (isPlaying) {
            isPlaying = false;
          } else {
            isPlaying = true;
          }
        });
        while (isPlaying) {
          _controller.jumpTo(
              xOffset: _controller.scrollOffset.dx,
              yOffset: _controller.scrollOffset.dy + offset);
          await Future.delayed(Duration(milliseconds: duration));
          if (_controller.pageCount == _controller.pageNumber) {
            setState(() {
              isPlaying = false;
            });
          }
        }
      },
      child: (isPlaying)
          ? const Icon(
              Icons.pause_circle,
              color: Colors.black,
            )
          : const Icon(
              Icons.play_circle,
              color: Colors.black,
            ),
    );
  }

  SpeedDialChild _makeFlaotingActionButtonSettings() {
    return SpeedDialChild(
      child: const Icon(Icons.settings),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return OptionPanel(song: widget.song);
        }));
      },
    );
  }

  SpeedDialChild _makeFloatingActionButtonZoomIn() {
    return SpeedDialChild(
      child: const Icon(Icons.zoom_in),
      onTap: () {
        _controller.zoomLevel = _controller.zoomLevel + 0.25;
      },
    );
  }

  SpeedDialChild _makeFloatingActionButtonZoomOut() {
    return SpeedDialChild(
      child: const Icon(Icons.zoom_out),
      onTap: () {
        _controller.zoomLevel = _controller.zoomLevel - 0.25;
      },
    );
  }
}
