import 'dart:convert';
import 'package:deiloul/models/prompt.dart';
import 'package:http/http.dart' as http;

Stream<String> callModel(Prompt prompt) async* {
  print('log: calling model ');
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  Map<String, dynamic> body = prompt.toJson();

  try {
    // Create a request with streaming
    final request =
        http.Request('POST', Uri.parse('http://127.0.0.1:8000/generate'))
          ..headers.addAll(headers)
          ..body = jsonEncode(body);

    // Send the request as a stream
    final responseStream = await http.Client().send(request);

    if (responseStream.statusCode.toString().startsWith('2')) {
      // Listen for streamed response chunks and yield them as a stream
      await for (var chunk in responseStream.stream.transform(utf8.decoder)) {
        print('log: $chunk');
        yield chunk; // Yield each chunk as it arrives
      }
    } else {
      print('log: ${responseStream.statusCode}');
      yield 'Error: ${responseStream.statusCode}';
    }
  } catch (e) {
    print('log: $e');
    yield 'Error: $e';
  }
}
