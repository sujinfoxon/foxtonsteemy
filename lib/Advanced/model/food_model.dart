import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String calories;
  final String photoUrl;
  final String description;
  final String name;
  final int price;
  final String volume;
  final String foodtype;
  final String from;
  final double latitude;
  final double longitude;
  final int distance;

  const Food({
    required this.calories,
    required this.description,
    required this.name,
    required this.price,
    required this.volume,
    required this.photoUrl,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.foodtype,
    required this.from,
  });

  Map<String, dynamic> toJson() => {
        'product-name': name,
        'product-price': price,
        'product-volume': volume,
        'product-calories': calories,
        'product-description': description,
        "product-img": photoUrl,
        "hotel-latitude": latitude.toInt(),
        "hotel-longitude": longitude,
        "hotel-distance": distance,
        "food-type": foodtype,
        "product-from": from,
      };

  static Food fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return Food(
      photoUrl: snapshot["product-img"],
      calories: snapshot["product-calories"],
      description: snapshot["product-description"],
      name: snapshot["product-name"],
      price: snapshot["product-price"],
      volume: snapshot["product-volume"],
      latitude: snapshot["hotel-latitude"],
      longitude: snapshot["hotel-longitude"],
      distance: snapshot["hotel-distance"],
      foodtype: snapshot["food-type"],
      from: snapshot["product-from"],
    );
  }
}
