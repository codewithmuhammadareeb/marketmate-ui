// lib/models/product_model.dart

class Product {
  final String title;
  final String price;
  final String description;
  final String image;
  final String brand;
  final String year;
  final bool warranty;
  final bool originalPacking;

  Product({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.brand,
    required this.year,
    required this.warranty,
    required this.originalPacking,
  });
}