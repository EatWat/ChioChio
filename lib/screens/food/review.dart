import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewService{
  getLatestReview(String userId) {
    return Firestore.instance
    .collection('Order')
    .where('userId', isEqualTo: userId)
    .orderBy('timeStamp', descending: true)
    .getDocuments();
  }
}