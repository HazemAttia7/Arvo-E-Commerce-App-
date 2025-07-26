import 'dart:math';

class ProductModel {
  final int id;
  final String? brand;
  final List<String?> images;
  final String title;
  final String description;
  final String category;
  final double price;
  final num discountPercentage;
  final List<String> tags;
  final String shippingInfo;

  bool operator ==(Object other) {
    if (other is! ProductModel) return false;
    return id == other.id;
  }

  ProductModel({
    required this.id,
    required this.brand,
    required this.images,
    required this.category,
    required this.price,
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.tags,
    required this.shippingInfo,
  });

  static List<ProductModel> getProductsListFromJSON(
    Map<String, dynamic> jsonData,
  ) {
    List<dynamic> products = jsonData["products"];

    List<ProductModel> productsLsit = [];
    for (var product in products) {
      List<String?> images = getImagesListFromJSON(product);
      ProductModel productModel = ProductModel(
        id: product["id"],
        brand: product["brand"],
        images: images,
        category: product["category"],
        price: product["price"],
        title: product["title"],
        description: product["description"],
        discountPercentage: product["discountPercentage"],
        tags: List<String>.from(product["tags"] ?? []),
        shippingInfo: product["shippingInformation"],
      );
      productsLsit.add(productModel);
    }
    return productsLsit;
  }

  factory ProductModel.fromJSON(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] as int,
      brand: json["brand"] as String?,
      images:
          (json["images"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      category: json["category"] as String,
      price: (json["price"] as num).toDouble(),
      title: json["title"] as String,
      description: json["description"] as String,
      discountPercentage: json["discountPercentage"] as num,
      tags: List<String>.from(json["tags"] ?? []),
      shippingInfo: json["shippingInformation"] as String,
    );
  }

  static List<String?> getImagesListFromJSON(product) {
    List<dynamic> jsonData = product["images"];
    List<String?> imagesList = List<String?>.filled(6, null);
    for (int i = 0; i < min(jsonData.length, imagesList.length); i++) {
      imagesList[i] = jsonData[i].toString();
    }
    return imagesList;
  }
}
