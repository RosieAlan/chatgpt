import 'package:flutter/material.dart';
import 'package:chatgpt/models/message.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final List<Message> messages = [
    Message(content: "Hello", isUser: true, timestamp: DateTime.now()),
    Message(content: "How are you?", isUser: false, timestamp: DateTime.now()),
    Message(
        content: "Fine,Thank you. And you?",
        isUser: true,
        timestamp: DateTime.now()),
    Message(content: "I am fine.", isUser: false, timestamp: DateTime.now()),
  ];
  final _textController = TextEditingController();

  _sendMessage(String content) {
    final message =
        Message(content: content, isUser: true, timestamp: DateTime.now());
    messages.add(message);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return MessageItem(message: messages[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 15,
                      );
                    },
                    itemCount: messages.length),
              ),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Message',
                    hintText: 'Enter your message',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          _sendMessage(_textController.text);
                        }
                        print('发送了一条消息${_textController.text}');
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    )), //suffixIcon的意思是  在输入框后面加一个图标
              )
            ],
          ),
        ));
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: message.isUser ? Colors.blue : Colors.red,
          child: Text(
            message.isUser ? 'user' : 'GPT',
          ),
        ),
        const SizedBox(
          width: 20,
        ), //作用是让两个组件之间有间隔
        Text(message.content),
      ],
    );
  }
}
