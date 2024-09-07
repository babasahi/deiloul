import 'package:deiloul/backend.dart';
import 'package:deiloul/prompt.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _promptController = TextEditingController();
  String _answer = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(_answer),
                ),
                const SizedBox(height: 120),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _promptController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await callModel(
                      Prompt(
                          message: _promptController.text.trim(),
                          user: 'saleh',
                          date: DateTime.now()),
                    ).then((v) {
                      setState(() {
                        if (v != null) {
                          _answer = v.answer;
                        }
                      });
                    });
                  },
                  child: const SizedBox(
                    height: 22,
                    width: 88,
                    child: Icon(
                      Icons.telegram,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
