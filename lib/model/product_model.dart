class ProductModel {
  final String uid;
  final String image;
  final String productName;
  final String descrption;
  final double cost;
  final String category;
  ProductModel({
    required this.category,
    required this.uid,
    required this.image,
    required this.productName,
    required this.descrption,
    required this.cost,
  });
  Map<String, dynamic> getJson() => {
        "uid": uid,
        "productName": productName,
        "descrption": descrption,
        "image": image,
        "category": category,
        "cost": cost,
      };
  factory ProductModel.getModelFromJson(Map<String, dynamic> json) {
    return ProductModel(
        category: json['category'],
        uid: json['uid'],
        image: json['image'],
        productName: json['productName'],
        descrption: json['descrption'],
        cost: json['cost']);
  }
}
