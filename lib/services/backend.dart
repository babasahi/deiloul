import 'dart:convert';
import 'package:deiloul/models/prompt.dart';
import 'package:deiloul/models/prompt_answer.dart';
import 'package:http/http.dart' as http;

Future<PromptAnswer?> callModel(Prompt prompt) async {
  print('log: calling model ');
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  Map<String, String> body = prompt.toJson();

  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/generate'),
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode.toString().startsWith('2')) {
      print(jsonDecode(response.body).toString());
      return PromptAnswer.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      print('log: ${response.statusCode} ${response.body.toString()}');
      return null;
    }
  } catch (e) {
    print('log: $e');
    return null;
  }
}
