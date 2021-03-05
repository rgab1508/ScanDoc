import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var flashState = 0;

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
                          Navigator.of(context).pushNamed('result_screen');
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
