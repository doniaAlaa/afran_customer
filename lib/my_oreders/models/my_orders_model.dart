

class MyOrdersModel {

  int? id;
  String? status;
  String? total_price;
  String? total_quantity;
  String? delivery_method;
  String? delivery_date;
  String? tracking_url;
  String? location;
  String? lat;
  String? long;
  bool? is_paid;
  String? created_at;
  Statuses? statuses;

  MyOrdersModel({
    this.id,
    this.total_price,
    this.status,
    this.total_quantity,
    this.delivery_method,
    this.delivery_date,
    this.tracking_url,
    this.location,
    this.lat,
    this.long,
    this.is_paid,
    this.created_at,
    this.statuses,

  });

  // Factory method to parse from JSON
  factory MyOrdersModel.fromJson(Map<String, dynamic> json) {
    return MyOrdersModel(
      id: json['id'],
      status: json['status'],
      total_price: json['total_price'],
      total_quantity: json['total_quantity'],
      delivery_method: json['delivery_method'],
      delivery_date: json['delivery_date'],
      tracking_url: json['tracking_url'],
      location: json['location'],
      lat: json['lat'],
      long: json['long'],
      is_paid: json['is_paid'],
      created_at: json['created_at'],
      statuses:json['statuses'] != null ? Statuses.fromJson(json['statuses']):null ,




    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total_price': total_price,
      'total_quantity': total_quantity,
      'delivery_method': delivery_method,
      'delivery_date': delivery_date,
      'location': location,
      'lat': lat,
      'long': long,
      'is_paid': is_paid,
      'created_at': created_at,


    };
  }
}




class Statuses {

  int? id;
  String? status;
  String? total_price;
  String? total_quantity;
  String? delivery_method;
  String? delivery_date;
  String? tracking_url;
  String? location;
  String? lat;
  String? long;
  bool? is_paid;
  String? created_at;
  Statuses? statuses;

  Statuses({
    this.id,
    this.total_price,
    this.status,
    this.total_quantity,
    this.delivery_method,
    this.delivery_date,
    this.tracking_url,
    this.location,
    this.lat,
    this.long,
    this.is_paid,
    this.created_at,
    this.statuses,

  });

  // Factory method to parse from JSON
  factory Statuses.fromJson(Map<String, dynamic> json) {
    return Statuses(
      id: json['id'],
      status: json['status'],
      total_price: json['total_price'],
      total_quantity: json['total_quantity'],
      delivery_method: json['delivery_method'],
      delivery_date: json['delivery_date'],
      tracking_url: json['tracking_url'],
      location: json['location'],
      lat: json['lat'],
      long: json['long'],
      is_paid: json['is_paid'],
      created_at: json['created_at'],



    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total_price': total_price,
      'total_quantity': total_quantity,
      'delivery_method': delivery_method,
      'delivery_date': delivery_date,
      'location': location,
      'lat': lat,
      'long': long,
      'is_paid': is_paid,
      'created_at': created_at,


    };
  }
}
