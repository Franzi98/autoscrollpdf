# AutoScrollPDF

AutoScrollPDF is a simply App wrote in Dart (with framework Flutter). It allow you to automatically scroll PDF files. It is useful to play a musical score, for example,  or read a book without scroll manually.

## How to use

You can use this app **offline** but you can open a online PDF document in the web simply past the link. In offline mode, you have to choose a PDF file with your file manager.

## Dependencies

- syncfusion_flutter_pdfviewer: ^20.2.36-beta
- file_picker: ^4.6.1
- shared_preferences: ^2.0.15
- flutter_speed_dial: ^6.0.0


## How are used dependencies

**Syncfusion_flutter_pdfviewer** : allow to view PDF file, scroll, zoom
**file_picker**: to select a PDF file in your file manager
**shared_preferences**: to save preferences in memory device
**flutter_speed_dial: ^6.0.0**: to open multiple floatingactionbuttons
**json_serializable: ^6.3.1**: to encode/decode file
**build_runner: ^2.2.0**: to generate file

## Change preferences

For every PDF you can change option (Scrolling time, offset and tags). 
Tags help you to search immediatly PDFs, Scrolling time allow to improve e decrease scrolling speed, offset improve e decrease scrolling offset. 

## TODO

 -[ ] Open Online Document
 -[ ] Add history Documents
 -[X] Save PDF
