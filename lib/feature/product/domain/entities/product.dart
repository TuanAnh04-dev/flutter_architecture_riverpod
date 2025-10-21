class Product {
  final int id;
  final String? title;
  final String? description;
  final String? category;
  final dynamic price;
  final dynamic discountPercentage;
  final dynamic rating;
  final int stock;
  final List<dynamic> tags;
  final String? brand;
  final String? sku;
  final int weight;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final String? returnPolicy;
  final int minimumOrderQuantity;
  final String? thumbnail;
  final List<dynamic> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.thumbnail,
    required this.images,
  });
}
