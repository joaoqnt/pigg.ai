import 'dart:convert';

class CategoryModel {
  int? id;
  String name;
  String color; // ex: "#695fc4"
  String icon;  // ex: "food_bank"

  CategoryModel({
    this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'color': color,
    'icon': icon,
  };

  String toRawJson() => jsonEncode(toJson());

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(jsonDecode(str));
}
