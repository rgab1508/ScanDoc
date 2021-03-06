import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Doc"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            DocumentTile(
              title: "IA1_1019121_EM_Q2",
              pages: 10,
              date: "3rd Jan 2021",
            ),
            DocumentTile(
              title: "IA1_1019121_EM_Q2",
              pages: 10,
              date: "3rd Jan 2021",
            ),
            DocumentTile(
              title: "IA1_1019121_EM_Q2",
              pages: 10,
              date: "3rd Jan 2021",
            ),
            DocumentTile(
              title: "IA1_1019121_EM_Q2",
              pages: 10,
              date: "3rd Jan 2021",
            ),
            DocumentTile(
              title: "IA1_1019121_EM_Q2",
              pages: 10,
              date: "3rd Jan 2021",
            ),
            DocumentTile(
              title: "IA1_1019121_EM_Q2",
              pages: 10,
              date: "3rd Jan 2021",
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70,
        width: 80,
        child: FloatingActionButton(
          isExtended: true,
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('scan_screen');
          },
          child: Icon(
            Icons.camera_alt,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class DocumentTile extends StatefulWidget {
  final String title;
  final int pages;
  final String date;

  DocumentTile({this.title, this.pages, this.date});

  @override
  _DocumentTileState createState() => _DocumentTileState();
}

class _DocumentTileState extends State<DocumentTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[800], borderRadius: BorderRadius.circular(5.0)),
      height: 200,
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            child: Placeholder(
              fallbackHeight: 200,
              fallbackWidth: 130,
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, bottom: 5.0, top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // children: [
                        Text(
                          this.widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(Icons.more_vert),
                        // )
                        // ],
                        // ),
                        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                        Text(
                          this.widget.pages.toString() + " pages",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          this.widget.date,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
