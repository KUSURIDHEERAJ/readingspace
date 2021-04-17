import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:reading_space/models/book.dart';
import 'package:reading_space/models/group.dart';
import 'package:reading_space/services/database.dart';

class CurrentGroup extends ChangeNotifier {
  OurGroup currentGroup = OurGroup();
  OurBook currentBook = OurBook();
  bool doneWithCurrentBook = false;
  OurGroup get getCurrentGroup => currentGroup;
  OurBook get getCurrentBook => currentBook;
  bool get getDoneWithCurrentBook => doneWithCurrentBook;
  void updateStateFromDatabase(String groupId, String userUid) async {
    try {
      //get the group info from firebase
      //get current book info from firebase
      currentGroup = await OurDatabase().getGroupInfo(groupId);
      currentBook = await OurDatabase()
          .getCurrentBook(groupId, currentGroup.currentBookId);
      notifyListeners();
      doneWithCurrentBook = await OurDatabase()
          .isUserDoneWithBook(groupId, currentGroup.currentBookId, userUid);
    } catch (e) {
      print(e);
    }
  }

  void finishedBook(String userUid, int rating, String review) async {
    try {
      await OurDatabase().finishedBook(
          currentGroup.id, currentGroup.currentBookId, userUid, rating, review);
      doneWithCurrentBook = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
