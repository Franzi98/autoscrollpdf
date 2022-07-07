import 'dart:io';

import 'package:autoscrollpdf/Helper/ParametersHelper.dart';
import 'package:autoscrollpdf/android/otherActivity/OptionPanel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfActivityAndroid extends StatefulWidget {
  final String path;
  final bool onlineAssets;
  PdfActivityAndroid({Key? key, required this.path, required this.onlineAssets})
      : super(key: key);

  @override
  State<PdfActivityAndroid> createState() => _PdfActivityAndroidState();
}

class _PdfActivityAndroidState extends State<PdfActivityAndroid> {
  bool isPlaying = false;
  late PdfViewerController _controller;
  int? duration = 0;
  double? offset = 0.0;
  @override
  void initState() {
    _controller = PdfViewerController();
    duration = ParametersHelper.getDuration();
    duration ??= 50;
    offset = ParametersHelper.getOffset();
    offset ??= 2.0;
    //print(offset);
    //print(duration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return exit(0);
      },
      child: Scaffold(
          appBar: _makeAppBar(),
          body: SafeArea(child: makePDFView(widget.onlineAssets)),
          floatingActionButton: _makeFloatingActionButton()),
    );
  }

  AppBar _makeAppBar() {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              _controller.zoomLevel = _controller.zoomLevel + 0.25;
            },
            icon: const Icon(
              Icons.zoom_in,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              _controller.zoomLevel = _controller.zoomLevel - 0.25;
            },
            icon: const Icon(
              Icons.zoom_out,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OptionPanel(
                  path: widget.path,
                  isOnline: widget.onlineAssets,
                );
              }));
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ))
      ],
    );
  }

  Widget makePDFView(bool onlineAssets) {
    if (onlineAssets) {
      return SfPdfViewer.network(
        widget.path,
        controller: _controller,
      );
    } else {
      return SfPdfViewer.asset(
        widget.path,
        controller: _controller,
      );
    }
  }

  FloatingActionButton _makeFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
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
              yOffset: _controller.scrollOffset.dy + 2);
          await Future.delayed(Duration(milliseconds: duration!));
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
              color: Colors.white,
            )
          : const Icon(
              Icons.play_circle,
              color: Colors.white,
            ),
    );
  }
}
