import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/food_item.dart';

// Add a new food item to Firestore
Future<void> addFoodItem(FoodItem foodItem) async {
  CollectionReference foodItemsRef = FirebaseFirestore.instance.collection('foodItems');
  await foodItemsRef.add(foodItem.toJson());
}

// Update a food item in Firestore
Future<void> updateFoodItem(String foodItemId, FoodItem updatedFoodItem) async {
  DocumentReference foodItemRef = FirebaseFirestore.instance.collection('foodItems').doc(foodItemId);
  await foodItemRef.update(updatedFoodItem.toJson());
}

// Delete a food item from Firestore
Future<void> deleteFoodItem(String foodItemId) async {
  DocumentReference foodItemRef = FirebaseFirestore.instance.collection('foodItems').doc(foodItemId);
  await foodItemRef.delete();
}

// Search for food items by name in Firestore
Future<List<dynamic>> searchFoodItems(String searchTerm) async {
  CollectionReference foodItemsRef = FirebaseFirestore.instance.collection('foodItems');
  QuerySnapshot querySnapshot = await foodItemsRef.where('name', isGreaterThanOrEqualTo: searchTerm).get();
  List<dynamic> foodItems = querySnapshot.docs.map((doc) => doc.data()).toList();
  return foodItems;
}
