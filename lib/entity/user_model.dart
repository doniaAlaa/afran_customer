
class UserModel {
  int? id;
  String? role;
  String? image;
  String? name;
  String? phone;
  String? email;
  bool? is_active;
  double? lat;
  double? long;
  String? location;
  String? distance;
  String? owner;
  String? open;
  String? close;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.role,
    this.image,
    this.name,
    this.phone,
    this.email,
    this.is_active,
    this.lat,
    this.long,
    this.location,
    this.distance,
    this.open,
    this.close,
    this.owner,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to parse from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      role: json['role'],
      image: json['image'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      is_active: json['is_active'],
      lat: json['lat'] != null ? json['lat'].toDouble() : null,
      long: json['long'] != null ? json['long'].toDouble() : null,
      location: json['location'],
      distance: json['distance'],
      owner: json['owner'],
      open: json['open'],
      close: json['close'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'image': image,
      'name': name,
      'phone': phone,
      'email': email,
      'is_active': is_active,
      'lat': lat,
      'lng': long,
      'location': location,
      'distance': distance,
      'owner': owner,
      'open': open,
      'close': close,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
