
class ProductModel {
  int? id;
  String? image;
  String? name;
  String? owner;
  String? price;
  String? selling_price;
  bool? is_active;
  bool? is_favorite;
  String? distance;
  num? duration;
  String? duration_type;
  String? description;
  String? user;
  num? rate;
  int? quantity;
  String? category;
  int? category_id;
  String? category_name;
  String? createdAt;
  String? updatedAt;
  List<SizesAndAddons>? sizes;
  List<SizesAndAddons>? addons;

  ProductModel({
    this.id,
    this.image,
    this.name,
    this.owner,
    this.price,
    this.duration,
    this.selling_price,
    this.is_active,
    this.is_favorite,
    this.distance,
    this.duration_type,
    this.description,
    this.user,
    this.rate,
    this.quantity,
    this.category,
    this.category_id,
    this.category_name,
    this.sizes,
    this.addons,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to parse from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['image'],
      owner: json['owner'],
      name: json['name'],
      user: json['user'],
      rate: json['rate'],
      price: json['price'],
      is_active: json['is_active'],
      is_favorite: json['is_favorite'],
      duration: json['duration'],
      selling_price: json['selling_price'],
      distance: json['distance'],
      description: json['description'],
      category: json['category'],
      category_id: json['category_id'],
      category_name: json['category_name'],
      duration_type: json['duration_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      quantity: json['quantity'],
      sizes:json['sizes'] != null? List<SizesAndAddons>.from(
          json['sizes'].map((x) => SizesAndAddons.fromJson(x))):null,
      addons:json['addons'] != null? List<SizesAndAddons>.from(
          json['addons'].map((x) => SizesAndAddons.fromJson(x))):null,

    );
  }

  // copyWith method
  ProductModel copyWith({
    int? id,
    String? image,
    String? name,
    String? owner,
    String? price,
    String? selling_price,
    bool? is_active,
    bool? is_favorite,
    String? distance,
    num? duration,
    String? duration_type,
    String? description,
    String? user,
    num? rate,
    String? category,
    String? category_name,
    int? category_id,
    String? createdAt,
    String? updatedAt,
    int? quantity,
    List<SizesAndAddons>? sizes,
    List<SizesAndAddons>? addons,
  }) {
    return ProductModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      price: price ?? this.price,
      selling_price: selling_price ?? this.selling_price,
      is_active: is_active ?? this.is_active,
      is_favorite: is_favorite ?? this.is_favorite,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      duration_type: duration_type ?? this.duration_type,
      description: description ?? this.description,
      user: user ?? this.user,
      rate: rate ?? this.rate,
      createdAt: createdAt ?? this.createdAt,
      category_id: category_id ?? this.category_id,
      category_name: category_name ?? this.category_name,
      updatedAt: updatedAt ?? this.updatedAt,
      sizes: sizes ?? this.sizes,
      addons: addons ?? this.addons,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,

    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'owner': owner,
      'price': price,
      'is_active': is_active,
      'is_favorite': is_favorite,
      'duration': duration,
      'distance': distance,
      'description': description,
      'duration_type': duration_type,
      'user': user,
      'rate': rate,
      'category': category,
      'category_id': category_id,
      'category_name': category_name,
      'sizes': sizes,
      'addons': addons,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'quantity': quantity,
    };
  }
}


//////////////////////////////////////////////////

class SizesAndAddons {
  int? id;
  String? name;
  String? price;
  String? selling_price;


  SizesAndAddons({
    this.id,
    this.name,
    this.price,
    this.selling_price,

  });

  // Factory method to parse from JSON
  factory SizesAndAddons.fromJson(Map<String, dynamic> json) {
    return SizesAndAddons(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      selling_price: json['selling_price'],



    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'selling_price': selling_price,

    };
  }
}
