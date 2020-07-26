import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwat/models/foodcourt_model.dart';
import 'package:eatwat/models/Store_model.dart';
import 'package:eatwat/models/food_model.dart';
import 'package:eatwat/models/order_model.dart';


class DatabaseService {

  // foodcourts collection reference
  // now we can read / update / delete the documents in the collection
  final CollectionReference foodcourtCollection = Firestore.instance.collection('FoodCourts');

  // foodcourt list from snapshot 
  List<Foodcourt> _foodcourtListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Foodcourt(
        name: doc.data['name'],
        location: doc.data['location'],
        //faculty: doc.data['faculty'],
        image: doc.data['photo'],
        id: doc.documentID
      );
    }).toList();
  }

  // get foodcourt stream
  Stream<List<Foodcourt>> get foodcourts {
    return foodcourtCollection.snapshots()
      .map(_foodcourtListFromSnapshot);
  }


  //Store
  final CollectionReference storeCollection = Firestore.instance.collection('FoodStores');

  List<Store> _storeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Store(
        name: doc.data['name'],
        location: doc.data['location'],
        //faculty: doc.data['faculty'],
        image: doc.data['photo'],
        category: doc.data['category'],
        availability: doc.data['availability'],
        id: doc.data['id'],
        foodCourtId: doc.data['foodCourtId'],
        //openingHour: doc.data['opening_hours']
      );
    }).toList();
  }

  Stream<List<Store>> get stores {
    return storeCollection.snapshots()
      .map(_storeListFromSnapshot);
  }

  //Food(dish)
  
  final CollectionReference foodCollection = Firestore.instance.collection('Dish');

  List<Food> _foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Food(
        name: doc.data['name'],
        image: doc.data['photo'],
        price: doc.data['price'].toDouble(),
        id: doc.data['foodStoreId'],
        availability: doc.data['availability'],
        des: doc.data['description']
        //openingHour: doc.data['opening_hours']
      );
    }).toList();
  }
  
  

  Stream<List<Food>> get food {
    return foodCollection.snapshots()
      .map(_foodListFromSnapshot);
  }

  // Order

  final CollectionReference orderCollection = Firestore.instance.collection('Order');

  //final Future<QuerySnapshot> orderCollection = Firestore.instance.collection('Order').orderBy('time', descending: true).getDocuments();

  List<Order> _orderFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Order(
        dishes: doc.data['dishes'],
        foodStoreId: doc.data['foodStoreId'],
        status: doc.data['status'],
        time: doc.data['time'],
        totalPrice: doc.data['totalPrice'].toDouble(),
        userId: doc.data['userId'],
        foodStoreName: doc.data['foodStoreName'],
        documentID: doc.data["documentID"]
      );
    }).toList();
  }
  

  Stream<List<Order>> get orders {
    return orderCollection.snapshots()
      .map(_orderFromSnapshot);
  }


}