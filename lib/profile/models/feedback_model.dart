

class FeedbackModel {
  int? id;
  int? rating;
  String? provider_name;
  String? feedback;
  String? status;
  String? time_ago;
  String? created_at;
  User? user;


  FeedbackModel({
    this.id,
    this.rating,
    this.provider_name,
    this.feedback,
    this.status,
    this.time_ago,
    this.created_at,
    this.user,

  });

  // Factory method to parse from JSON
  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      rating: json['rating'],
      provider_name: json['provider_name'],
      feedback: json['feedback'],
      status: json['status'],
      time_ago: json['time_ago'],
      created_at: json['created_at'],
      user:json['user'] != null ? User.fromJson(json['user']):null ,



    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'provider_name': provider_name,
      'feedback': feedback,
      'status': status,
      'time_ago': time_ago,
      'created_at': created_at,

    };
  }
}




class User {
  int? id;
  String? name;
  String? image;



  User({
    this.id,
    this.name,
    this.image,

  });

  // Factory method to parse from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
