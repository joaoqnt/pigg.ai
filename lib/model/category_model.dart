import 'dart:convert';

class CategoryModel {
  int? id;
  String name;
  String type;  // "income" ou "expense"
  String color; // ex: "#695fc4"

  CategoryModel({
    this.id,
    required this.name,
    required this.type,
    required this.color,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'color': color,
  };

  String toRawJson() => jsonEncode(toJson());

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(jsonDecode(str));
}
