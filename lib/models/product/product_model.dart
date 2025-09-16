class ProductModel {
  final int id;
  final String name;
  final double price;
  final String image;

  bool? isFavorite;

  ProductModel({required this.id, required this.name, required this.price, required this.image});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(id: json['id'], name: json['title'], price: json['price'].toDouble(), image: json['thumbnail']);
  }
}
