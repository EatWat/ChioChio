import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final List<dynamic> dishes;
  final String foodStoreId;
  var status;
  
  final Timestamp time;
  final double totalPrice;
  final String userId;
  final String foodStoreName;

  Order({this.dishes, this.foodStoreId, this.status, this.time, this.totalPrice, this.userId, this.foodStoreName});

}
