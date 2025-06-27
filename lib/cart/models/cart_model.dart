
import 'package:afran/home/models/product_model.dart';


class CartModel {
  int? id;
  List<CartItemModel>? items;
  int? total_qty;
  num? total_price;



  CartModel({
    this.id,
    this.items,
    this.total_qty,
    this.total_price,



  });

  // Factory method to parse from JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      items: List<CartItemModel>.from(
          json['items'].map((x) => CartItemModel.fromJson(x))),
      total_qty: json['total_qty'],
      total_price: json['total_price'],


    );
  }



  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_qty': total_qty,
      'total_price': total_price,


    };
  }
}

class CartItemModel {
  int? id;
  ProductModel? product;
  String? size;
  int? quantity;
  List<SizesAndAddons>? addons;


  CartItemModel({
    this.id,
    this.product,
    this.size,
    this.quantity,
    this.addons,

  });

  // Factory method to parse from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      size: json['size'],
      product : json['product'] != null
          ? new ProductModel.fromJson(json['product'])
          : null,
      quantity: json['quantity'],
      addons:json['addons'] != null? List<SizesAndAddons>.from(
          json['addons'].map((x) => SizesAndAddons.fromJson(x))):null,

    );
  }



  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'size': size,
      'product':product,
      'quantity': quantity,
      'addons': addons,

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
