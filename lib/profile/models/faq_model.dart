

class FaqModel {
  int? id;
  String? question;
  String? answer;
  String? type;
  bool? is_active;


  FaqModel({
    this.id,
    this.question,
    this.answer,
    this.type,
    this.is_active,

  });

  // Factory method to parse from JSON
  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      type: json['type'],
      is_active: json['is_active'],



    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'type': type,
      'is_active': is_active,

    };
  }
}
