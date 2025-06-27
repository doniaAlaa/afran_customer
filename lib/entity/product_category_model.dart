
class ProductCategoryModel {
  int? id;
  String? name;
  String? image;


  ProductCategoryModel({
    this.id,
    this.name,
    this.image,

  });

  // Factory method to parse from JSON
  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],

    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,

    };
  }
}
