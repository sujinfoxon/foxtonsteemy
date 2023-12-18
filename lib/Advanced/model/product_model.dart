class ProductModel {
  final String url;
  final String productName;
  final double cost;
  final String uid;
  final int rating;
  final int noOfRating;
  final String calories;
  final String volume;
  final String description;
  final int discount;

  ProductModel({
    required this.url,
    required this.productName,
    required this.cost,
    required this.uid,
    required this.rating,
    required this.noOfRating,
    required this.calories,
    required this.volume,
    required this.description,
    required this.discount,
  });

  Map<String, dynamic> getJson() {
    return {
      'url': url,
      'product-name': productName,
      'product-price': cost,
      'product-volume': volume,
      'product-calories': calories,
      'product-description': description,
      'uid': uid,
      'rating': rating,
      'noOfRating': noOfRating,
    };
  }

  factory ProductModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ProductModel(
        url: json["url"],
        productName: json["product-name"],
        cost: json["product-price"].toDouble(),
        uid: json["uid"],
        rating: json["rating"],
        noOfRating: json["noOfRating"],
        calories: json["product-calories"],
        volume: json["product-volume"],
        description: json["product-description"],
        discount: json["rating"]);
  }
}
