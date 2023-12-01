import 'package:devfest/model/chat_model.dart';
import 'package:flutter/material.dart';

class ChatComponent extends StatelessWidget {
  const ChatComponent(this.chat, {super.key});

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MessageComponent(message: chat.question),
        MessageComponent(message: chat.answer, isAnswer: true),
      ],
    );
  }
}

class MessageComponent extends StatelessWidget {
  const MessageComponent({
    required this.message,
    this.isAnswer = false,
    super.key,
  });

  final String message;
  final bool isAnswer;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isAnswer ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isAnswer ? Colors.grey : Colors.blue,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
