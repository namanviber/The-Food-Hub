import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thefoodhub/controllers/auth_controllers.dart';

import '../models/food_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = AuthController();
  final CollectionReference foodItemsCollection =
      FirebaseFirestore.instance.collection('foodItems');

  String _searchText = ''; // Store the search text entered by the user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "The Food Hub",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                authController.logoutUser();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  labelText: "Search",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.deepOrange,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Popular Food Items",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: foodItemsCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<FoodItem> foodItems = snapshot.data!.docs
                        .map((doc) => FoodItem.fromMap(
                            doc.data() as Map<String, dynamic>))
                        .toList();

                    // Filter the food items based on the search text
                    if (_searchText.isNotEmpty) {
                      foodItems = foodItems
                          .where((foodItem) => foodItem.name
                              .toLowerCase()
                              .contains(_searchText.toLowerCase()))
                          .toList();
                    }

                    return ListView.builder(
                      itemCount: foodItems.length,
                      itemBuilder: (context, index) {
                        FoodItem foodItem = foodItems[index];

                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Movie photo
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(foodItem.imageUrl),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Movie title
                                      Text(
                                        foodItem.name,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        foodItem.description,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  children: [
                                    Text('${foodItem.price} Rs'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.shopping_cart_rounded,
                                          color: Colors.deepOrange,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
