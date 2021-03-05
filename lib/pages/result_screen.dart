import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.pink[50],
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(25.0, 20.0, 20.0, 25.0),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ImageTile(),
                      ImageTile(),
                      ImageTile(),
                      ImageTile()
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  child: Row(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.white,
                          size: 30,
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
      child: Placeholder(),
    );
  }
}
