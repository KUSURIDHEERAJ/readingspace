import 'package:cloud_firestore/cloud_firestore.dart';

class OurBook {
  String id;
  String name;
  String author;
  int length;
  Timestamp dataCompleted;

  var dateCompleted;

  OurBook({
    this.id,
    this.name,
    this.length,
    this.dataCompleted,
  });
}
