class Question {
  final String categoryName;
  final String question;
  final bool requiresValue;
  final String? valueLabel;
  final bool answered;
  final bool defaultRequiresAnswer;
  final bool? requiresAnswer;
  final double? labelAnswer;

  Question({
    required this.categoryName,
    required this.question,
    required this.requiresValue,
    this.valueLabel,
    this.answered = false,
    this.defaultRequiresAnswer = true,
    this.requiresAnswer,
    this.labelAnswer,
  });


}
