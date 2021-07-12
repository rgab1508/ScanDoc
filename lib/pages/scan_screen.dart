import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var flashState = 0;
  CameraController controller;
  List<File> _images = [];
  bool _controllerLoaded = false;
  File currImage;

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void asyncInitState() async {
    final filePermStatus = await Permission.storage.status;
    if (filePermStatus.isDenied) {
      final req = await Permission.storage.request();
      if (req.isGranted) {}
      if (req.isDenied) {
        // todo exit App here
      }
    }

    final cameras = await availableCameras();
    controller =
        CameraController(cameras[0], ResolutionPreset.max, enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _controllerLoaded = true;
      });
    });
  }

  void addImage() async {
    var img = await controller.takePicture();

    setState(() {
      _images.add(File(img.path));
      print(_images);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('home_screen');
          },
          icon: Icon(Icons.home),
        ),
        actions: [
          Visibility(
              visible: _images.length > 0,
              child: Container(
                alignment: Alignment.center,
                child: Text("${_images.length} pages",
                    style: TextStyle(fontSize: 16)),
              ))
        ],
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                child: Container(
                  color: Colors.pink[50],
                  child: !_controllerLoaded
                      ? Container()
                      : CameraPreview(controller),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
                color: Colors.black,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          var next = flashState + 1;
                          if (next >= 3) next = 0;
                          if (next == 0) {
                            controller.setFlashMode(FlashMode.off);
                          } else if (next == 1) {
                            controller.setFlashMode(FlashMode.auto);
                          } else {
                            controller.setFlashMode(FlashMode.always);
                          }
                          setState(() {
                            flashState = next;
                          });
                        },
                        child: Icon(
                          flashState == 0
                              ? Icons.flash_off_rounded
                              : flashState == 1
                                  ? Icons.flash_auto_outlined
                                  : flashState == 2
                                      ? Icons.flash_on_outlined
                                      : Icons.flash_on_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          addImage();
                        },
                        child: Icon(
                          Icons.radio_button_off_rounded,
                          size: 100,
                          color: Colors.white,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          controller.dispose();
                          Navigator.of(context).pushReplacementNamed(
                              'result_screen',
                              arguments: <String, List<File>>{
                                "images": _images
                              });
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
