import 'dart:convert';

import 'package:devfest/model/chat_model.dart';
import 'package:http/http.dart' as http;

class ChatController {
  Future<ChatModel?> getAnswer(String question) async {
    try {
      final body = {
        'question': question,
      };
      final result = await http.post(
          Uri.parse('https://devfestapi-hchgg5q5rq-rj.a.run.app/bot'),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer mysupertoken',
            'uid': '123xyz,',
            "content-type": "application/json",
            "accept": "application/json",
          });

      if (result.statusCode != 200) return null;
      final chatJson = jsonDecode(result.body);
      return ChatModel(question: question, answer: chatJson['answer']);
    } catch (e) {
      return null;
    }
  }
}
