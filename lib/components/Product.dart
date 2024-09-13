class Product {
  String? name;
  String? details;
  String? usage;
  String? warning;
  String? category;
  String? quantity;
  String? price;
  String? imageUrl;

  Product({
    this.name,
    this.details,
    this.usage,
    this.warning,
    this.category,
    this.quantity,
    this.price,
    this.imageUrl,
  });

  // Convert a Product object into a map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name ?? '',
      'details': details ?? '',
      'usage': usage ?? '',
      'warning': warning ?? '',
      'category': category ?? '',
      'quantity': quantity ?? '',
      'price': price ?? '',
      'imageUrl': imageUrl ?? '',
    };
  }
}
