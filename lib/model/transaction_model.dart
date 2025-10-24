import 'dart:convert';

import 'category_model.dart';

class TransactionModel {
  int? id;
  double amount;
  String description;
  String type; // 'income' | 'expense'
  DateTime date;
  CategoryModel category; // obrigatória agora

  TransactionModel({
    this.id,
    required this.amount,
    required this.description,
    required this.type,
    required this.date,
    required this.category,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      type: json['type'],
      date: DateTime.parse(json['date']),
      category: CategoryModel.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'description': description,
    'type': type,
    'date': date.toIso8601String(),
    'category_id': category.id,
  };

  String toRawJson() => jsonEncode(toJson());
}
