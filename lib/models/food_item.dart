class FoodItem {
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  FoodItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Convert FoodItem object to Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  // Factory method to create FoodItem object from Map
  factory FoodItem.fromMap(Map<String, dynamic> data) {
    return FoodItem(
      name: data['name'],
      description: data['description'],
      price: data['price'],
      imageUrl: data['imageUrl'],
    );
  }
}
