import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_space/models/book.dart';
import 'package:reading_space/models/group.dart';
import 'package:reading_space/models/user.dart';

class OurDatabase {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Future<String> createUser(OurUser user) async {
    String returnVal = "error!";
    try {
      await fireStore.collection("users").doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      returnVal = "Success";
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser returnVal = OurUser();
    try {
      // ignore: unused_local_variable
      DocumentSnapshot docSnapshot =
          await fireStore.collection("users").doc(uid).get();
      returnVal.uid = uid;
      returnVal.fullName = docSnapshot.data()["fullName"];
      returnVal.email = docSnapshot.data()["email"];
      returnVal.accountCreated = docSnapshot.data()["accountCreated"];
      returnVal.groupId = docSnapshot.data()["groupId"];
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<String> createGroup(
      String groupName, String userUid, OurBook initialBook) async {
    String returnVal = "error!";
    List<String> members = [];
    try {
      members.add(userUid);
      DocumentReference documentReference =
          await fireStore.collection("groups").add({
        'name': groupName,
        'leader': userUid,
        'members': members,
        'groupCreate': Timestamp.now(),
      });
      await fireStore.collection("users").doc(userUid).update({
        'groupId': documentReference.id,
      });
      addBook(documentReference.id, initialBook);
      returnVal = "Success";
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<String> joinGroup(String groupId, String userUid) async {
    String returnVal = "error!";
    List<String> members = [];
    try {
      members.add(userUid);
      await fireStore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });
      await fireStore.collection("users").doc(userUid).update({
        'groupId': groupId,
      });
      returnVal = "Success";
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<OurGroup> getGroupInfo(String groupId) async {
    OurGroup returnVal = OurGroup();
    try {
      // ignore: unused_local_variable
      DocumentSnapshot docSnapshot =
          await fireStore.collection("groups").doc(groupId).get();
      returnVal.id = groupId;
      returnVal.name = docSnapshot.data()["name"];
      returnVal.leader = docSnapshot.data()["leader"];
      returnVal.members = List<String>.from(docSnapshot.data()["members"]);
      returnVal.groupCreated = docSnapshot.data()["groupCreated"];
      returnVal.currentBookId = docSnapshot.data()["currentBookId"];
      returnVal.currentBookDue = docSnapshot.data()["currentBookDue"];
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<String> addBook(String groupId, OurBook book) async {
    String returnVal = "error!";
    try {
      DocumentReference documentReference = await fireStore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .add({
        'name': book.name,
        'author': book.author,
        'length': book.length,
        'completedOn': book.dateCompleted,
      });
      //add current book to the group schedule
      await fireStore.collection("groups").doc(groupId).update({
        'currentBookId': documentReference.id,
        'currentBookDue': book.dateCompleted,
      });
      returnVal = "Success";
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<OurBook> getCurrentBook(String groupId, String bookId) async {
    OurBook returnVal = OurBook();
    try {
      // ignore: unused_local_variable
      DocumentSnapshot docSnapshot = await fireStore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .doc(bookId)
          .get();
      returnVal.id = bookId;
      returnVal.name = docSnapshot.data()["name"];
      returnVal.author = docSnapshot.data()["author"];
      returnVal.length = docSnapshot.data()["length"];
      returnVal.dateCompleted = docSnapshot.data()["dateCompleted"];
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<String> finishedBook(String groupId, String bookId, String uid,
      int rating, String review) async {
    String returnVal = "error!";
    try {
      await fireStore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .doc(bookId)
          .collection("reviews")
          .doc(uid)
          .set({
        'rating': rating,
        'review': review,
      });
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<bool> isUserDoneWithBook(
      String groupId, String bookId, String uid) async {
    bool returnVal = false;
    try {
      DocumentSnapshot documentSnapshot = await fireStore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .doc(bookId)
          .collection("reviews")
          .doc(uid)
          .get();
      if (documentSnapshot.exists) {
        returnVal = true;
      }
    } catch (e) {
      print(e);
    }
    return returnVal;
  }

  Future<List<OurBook>> getBookHistory(String groupId) async {
    List<OurBook> returnVal = [];
    try {
      QuerySnapshot query = await fireStore
          .collection("groups")
          .where("books", isEqualTo: true)
          .orderBy("completedOn", descending: true)
          .get();
    } catch (e) {
      print(e);
    }
    return returnVal;
  }
}
