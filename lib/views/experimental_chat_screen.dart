import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

class ExperimentalChatScreen extends StatefulWidget {
  const ExperimentalChatScreen({super.key});

  @override
  State<ExperimentalChatScreen> createState() => _ExperimentalChatScreenState();
}

class _ExperimentalChatScreenState extends State<ExperimentalChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.tab),
      ),
      body: LlmChatView(
        provider: 
      )
    );
  }
}

class MyLllmProvider extends LlmProvider {
  @override
  Iterable<ChatMessage> history;

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  Stream<String> generateStream(String prompt, {Iterable<Attachment> attachments}) {
    // TODO: implement generateStream
    throw UnimplementedError();
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  Stream<String> sendMessageStream(String prompt, {Iterable<Attachment> attachments}) {
   
  }
}
