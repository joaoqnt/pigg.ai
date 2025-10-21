import 'dart:convert';

class TransactionModel {
  int? id;
  double amount;
  String description;
  String type; // 'income' | 'expense'
  int categoryId;
  DateTime date;

  TransactionModel({
    this.id,
    required this.amount,
    required this.description,
    required this.type,
    required this.categoryId,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      type: json['type'],
      categoryId: json['category_id'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'description': description,
    'type': type,
    'category_id': categoryId,
    'date': date.toIso8601String(),
  };

  String toRawJson() => jsonEncode(toJson());

  factory TransactionModel.fromRawJson(String str) =>
      TransactionModel.fromJson(jsonDecode(str));
}
