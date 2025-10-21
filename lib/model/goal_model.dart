import 'dart:convert';

class GoalModel {
  int? id;
  String title;
  double targetAmount;
  double currentAmount;
  DateTime? dueDate;

  GoalModel({
    this.id,
    required this.title,
    required this.targetAmount,
    this.currentAmount = 0.0,
    this.dueDate,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'],
      title: json['title'],
      targetAmount: (json['target_amount'] as num).toDouble(),
      currentAmount: (json['current_amount'] as num).toDouble(),
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'target_amount': targetAmount,
    'current_amount': currentAmount,
    'due_date': dueDate?.toIso8601String(),
  };

  String toRawJson() => jsonEncode(toJson());

  factory GoalModel.fromRawJson(String str) =>
      GoalModel.fromJson(jsonDecode(str));
}
