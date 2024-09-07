class Prompt {
  final String message;
  final String user;
  final DateTime date;

  Prompt({
    required this.message,
    required this.user,
    required this.date,
  });

  String get formattedDate => date.toIso8601String();

  Map<String, String> toJson() => {
        'message': message,
        'user': user,
        'date': formattedDate,
      };
}
