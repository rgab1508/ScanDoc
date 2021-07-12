import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<File> _images = [];
  int _currImg = 0;
  bool _makingPdf = false;
  TextEditingController _fileNameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _deleteImage() {
    setState(() {
      _images.removeAt(_currImg);
    });
  }

  void _rotateImage() async {
    final img.Image ci = img.decodeImage(await _images[_currImg].readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(ci);

    final fi =
        await _images[_currImg].writeAsBytes(img.encodeJpg(orientedImage));
    setState(() {
      _images[_currImg] = fi;
    });
  }

  void _cropImage() {
    return;
  }

  void _makePdf() async {
    setState(() {
      _makingPdf = true;
    });

    final pdfDoc = pw.Document();

    for (var i = 0; i < _images.length; i++) {
      var page;
      final image = pw.MemoryImage(_images[i].readAsBytesSync());
      page = pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            );
          });
      pdfDoc.addPage(page);
    }

    // Directory appDocDir = await getExternalStorageDirectory();
    // print(appDocDir.path);
    final fileName = _fileNameController.text;
    File doc;

    doc = File('/storage/emulated/0/Documents/$fileName.pdf');

    await doc.writeAsBytes(await pdfDoc.save());

    setState(() {
      _makingPdf = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File Saved in Documents/$fileName.pdf")));
    Navigator.of(context).pushReplacementNamed('home_screen');
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, List<File>>;
    setState(() {
      _images = data["images"];
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('home_screen');
            },
            child: Icon(Icons.close_rounded),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save_rounded),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                          child: SimpleDialog(
                        contentPadding: EdgeInsets.all(20.0),
                        backgroundColor: Colors.black38,
                        children: _makingPdf
                            ? [
                                Container(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.pink[100],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                                  child: Center(
                                    child: Text("Creating Pdf...",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0)),
                                  ),
                                )
                              ]
                            : [
                                Container(
                                  child: Container(
                                    child: TextField(
                                      controller: _fileNameController,
                                      cursorHeight: 18.0,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          hintText: 'Enter a File Name',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          fillColor: Colors.black45),
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      _makePdf();
                                    },
                                    child: Text("Save"))
                              ],
                      ));
                    });
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.black87,
                  child: ScrollSnapList(
                      onItemFocus: (int index) {
                        setState(() {
                          _currImg = index;
                        });
                      },
                      itemSize: 40 + (MediaQuery.of(context).size.width * 0.8),
                      itemCount: _images.length,
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ImageTile(
                          file: _images[index],
                        );
                      }),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _deleteImage();
                          },
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.reorder_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.rotate_right_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.crop_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class ImageTile extends StatefulWidget {
  final File file;
  ImageTile({
    Key key,
    this.file,
  }) : super(key: key);
  @override
  _ImageTileState createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 45.0, 20.0, 45.0),
      color: Colors.deepPurpleAccent[100],
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Image.file(
        widget.file,
      ),
    );
  }
}
