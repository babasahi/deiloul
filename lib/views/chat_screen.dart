import 'package:deiloul/constants.dart';
import 'package:deiloul/models/prompt.dart';
import 'package:deiloul/models/prompt_answer.dart';
import 'package:deiloul/services/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Widget> feed = [];
  final TextEditingController _promptController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _handleNewPrompt() async {
    setState(() {
      feed.add(
        PromptQuestionWidget(
          promptQuestion: Prompt(
            message: _promptController.text.trim(),
            date: DateTime.now(),
            user: '',
          ),
        ),
      );
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.fastOutSlowIn,
    );
    await callModel(
      Prompt(
          message: _promptController.text.trim(),
          user: 'saleh',
          date: DateTime.now()),
    ).then((promptAnswer) {
      if (promptAnswer != null) {
        setState(() {
          feed.add(
            PromptAnswerWidget(
              promptAnswer: promptAnswer,
            ),
          );
        });

        _promptController.clear();
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.fastOutSlowIn,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Something went wrong',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        );
        setState(() {
          feed.removeLast();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.tab),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: feed.length,
                itemBuilder: (context, index) => feed[index],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  left: 16,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(44),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: TextField(
                        controller: _promptController,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          _handleNewPrompt();
                        },
                      ),
                    ),
                    IconButton(
                      color: kPrimaryColor.withOpacity(0.2),
                      onPressed: () {
                        _handleNewPrompt();
                      },
                      icon: const Icon(
                        Icons.telegram,
                        color: kPrimaryColor,
                        size: 36,
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 4,
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              child: Center(
                  child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSTaaUHLSKdxKeQRsjSuYVQQH0PLb9PVFYbA&s')),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth(context) * 0.8,
                  child: Text(
                    promptAnswer.answer,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: promptAnswer.answer,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Copied to clipboard',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        FontAwesomeIcons.copy,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PromptQuestionWidget extends StatelessWidget {
  const PromptQuestionWidget({super.key, required this.promptQuestion});

  final Prompt promptQuestion;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: screenWidth(context) * 0.7,
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          promptQuestion.message,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
