class Question {
  final String categoryName;
  final String categoryColor;
  final String categoryType;
  final String question;
  final bool requiresValue;
  final String? valueHint;
  final String? valueLabel;
  bool answered;
  final bool defaultRequiresAnswer;
  bool? requiresAnswer;
  double? labelAnswer;

  Question({
    required this.categoryName,
    required this.categoryColor,
    required this.categoryType,
    required this.question,
    required this.requiresValue,
    this.valueLabel,
    this.valueHint,
    this.answered = false,
    this.defaultRequiresAnswer = true,
    this.requiresAnswer,
    this.labelAnswer,
  });


}
