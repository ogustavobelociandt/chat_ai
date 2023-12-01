import 'package:devfest/controller/chat_controller.dart';
import 'package:devfest/model/chat_model.dart';
import 'package:devfest/view/chat_component.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textController = TextEditingController();
  bool loading = false;
  List<ChatModel> storedChats = [
    // const ChatModel(
    //     question: 'Você fala português?', answer: 'Sim, eu falo português'),
    // const ChatModel(
    //     question: 'O que é o DevFest?',
    //     answer:
    //         'DevFest é um evento de tecnologia criado por Alvaro e Luciano'),
    // const ChatModel(
    //     question: 'Quando aconteceu o último evento em Curitiba?',
    //     answer:
    //         'The question is about the last DevFest in Curitiba. The background information does not mention anything about DevFest. So we can say:\n\nI dont know. Can you tell me more about DevFest?'),
  ];

  void makeQuestion() async {
    setState(() {
      loading = true;
    });
    final chatController = ChatController();
    final chat = await chatController.getAnswer(textController.text);
    if (chat == null) {
      showErrorMessage();
      return;
    }
    textController.clear();
    setState(() {
      loading = false;
      storedChats.add(chat);
    });
  }

  void _hideLoading() {
    setState(() => loading = false);
  }

  void showErrorMessage() {
    _hideLoading();
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.lightBlueAccent,
        content: const Text('Não conseguimos obter a resposta!'),
        actions: [
          IconButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: storedChats.length,
              itemBuilder: (context, index) =>
                  ChatComponent(storedChats[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Qual sua dúvida?',
                border: const OutlineInputBorder(),
                suffixIcon: loading
                    ? const Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator())
                    : IconButton(
                        onPressed: makeQuestion,
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
