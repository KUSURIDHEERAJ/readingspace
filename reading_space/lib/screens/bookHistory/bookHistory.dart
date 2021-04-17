import 'package:flutter/material.dart';
import 'package:reading_space/models/book.dart';
import 'package:reading_space/services/database.dart';

class BookHistory extends StatefulWidget {
  final String groupId;
  BookHistory({
    this.groupId,
  });
  @override
  _BookHistoryState createState() => _BookHistoryState();
}

class _BookHistoryState extends State<BookHistory> {
  Future<List<OurBook>> books;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    books = OurDatabase().getBookHistory(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: books,
      ),
    );
  }
}
