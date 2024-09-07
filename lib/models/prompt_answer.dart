class PromptAnswer {
  final String answer;
  final String? model;
  final DateTime? dateTime;

  const PromptAnswer(
      {required this.answer, required this.dateTime, required this.model});

  factory PromptAnswer.fromJson(Map<String, dynamic> json) {
    return PromptAnswer(
      answer: json['answer'],
      dateTime: json['date'] == null ? null : DateTime.parse(json['date']),
      model: json['model'],
    );
  }
}
