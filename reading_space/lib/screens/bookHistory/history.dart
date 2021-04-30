import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OurHistory extends StatefulWidget {
  @override
  _OurHistoryState createState() => _OurHistoryState();
}

class _OurHistoryState extends State<OurHistory> {
  final List<String> names = <String>[
    'Abyawjfbaksj',
    'Aish',
    'Ayan',
    'Benadkasdc',
    'Bob',
    'Charlie',
    'Cook',
    'Carline'
  ];
  final List<String> author = <String>[
    'Abyieshs',
    'Aish',
    'Ayan',
    'Ben',
    'Bobdzvsdv',
    'Charlie',
    'Cook',
    'Carline'
  ];
  final List<String> review = <String>[
    'Abyieshs',
    'Aish',
    'Ayan',
    'Ben',
    'Bobdzvsdv',
    'Charlie',
    'Cook',
    'Carline'
  ];
  final List<int> rating = <int>[2, 0, 10, 6, 52, 4, 0, 2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reading Space History'),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(10),
                  separatorBuilder: (context, index) => Container(height: 8),
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 100,
                      margin: EdgeInsets.all(2),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment(-0.7, 0.0),
                        child: Text(
                          "Title: " '${names[index]}' +
                              "\n" +
                              "Author: " '(${author[index]})' +
                              "\n" +
                              "Review: " '(${review[index]})' +
                              "\n" +
                              "Rating: " '(${rating[index]})',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    );
                  }))
        ]));
  }
}
