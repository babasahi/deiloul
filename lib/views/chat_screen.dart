import 'dart:math';

import 'package:deiloul/models/prompt.dart';
import 'package:deiloul/models/prompt_answer.dart';
import 'package:deiloul/services/backend.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<PromptAnswer> answers = [];
  final TextEditingController _promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.tab),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView(
                children: answers
                    .map((answer) => PromptAnswerWidget(promptAnswer: answer))
                    .toList(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: TextField(
                        controller: _promptController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        /*
                        await callModel(
                          Prompt(
                              message: _promptController.text.trim(),
                              user: 'saleh',
                              date: DateTime.now()),
                        ).then((v) {
                          setState(() {
                            if (v != null) {
                              messages.add(
                                  '${v.answer} \n ${v.model} \n ${v.dateTime?.toIso8601String()}');
                              _promptController.clear();
                            }
                          });
                        });
                        */
                        setState(() {
                          answers.add(PromptAnswer(
                            answer: 'New message' * Random.secure().nextInt(8),
                            dateTime: DateTime.now(),
                            model: null,
                          ));
                        });
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromptAnswerWidget extends StatelessWidget {
  const PromptAnswerWidget({super.key, required this.promptAnswer});
  final PromptAnswer promptAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            promptAnswer.answer,
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(
                FontAwesomeIcons.volumeXmark,
              ),
              Icon(
                FontAwesomeIcons.soundcloud,
              ),
              Icon(
                FontAwesomeIcons.soundcloud,
              ),
              Icon(
                FontAwesomeIcons.soundcloud,
              )
            ],
          )
        ],
      ),
    );
  }
}
