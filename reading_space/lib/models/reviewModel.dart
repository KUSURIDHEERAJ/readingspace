import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String userId;
  int rating;
  String review;
  ReviewModel({
    this.userId,
    this.rating,
    this.review,
  });
  ReviewModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    userId = documentSnapshot.id;
    rating = documentSnapshot.data()["rating"];
    review = documentSnapshot.data()["review"];
  }
}
