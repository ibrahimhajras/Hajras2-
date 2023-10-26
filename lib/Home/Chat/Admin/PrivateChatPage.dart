import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled7/main.dart';
import '../../../Class/MessageController.dart';
import '../../../Constant/Allcolor.dart';
import '../../../FunctionDatabase/ChatAdminData.dart';
import '../../../FunctionDatabase/functionHomeadmin.dart';


late String ID;
class PrivateChatPage extends StatefulWidget {
  final int index;

  PrivateChatPage(this.index);

  @override
  _PrivateChatPageState createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  final TextEditingController _textController = TextEditingController();
  final MessageController messageController = Get.put(MessageController());
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    String receiverId = controller.data[widget.index]['id'].toString();
    fetchMessages(receiverId);
    _scrollController = ScrollController();
    ID = receiverId;
  }

  void fetchMessages(String receiverId) async {
    try {
      var response = await fetchDataFromServer(
          sharedPreferences.getString("id").toString(), receiverId);
      if (response is Map<String, dynamic>) {
        Map<String, dynamic> data = response;
        if (data.containsKey('status') && data['status'] == 's') {
          messageController.clearMessages();
          if (data.containsKey('data') && data['data'] is List) {
            List<dynamic> messages = data['data'];
            messages.forEach((message) {
              messageController.addMessage(message);
            });
          }
        } else {
          print('Failed to fetch data');
        }
      } else {
        print('Invalid response type');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _sendMessage(int index) {
    setState(() {
      String sender = sharedPreferences
          .getString("id")
          .toString();
      String receiver = controller.data[widget.index]['id'].toString();
      String textMessage = _textController.text;
      if (sender.isNotEmpty && receiver.isNotEmpty && textMessage.isNotEmpty) {
        sendMessageToDatabase(sender, receiver, textMessage);
        Map<String, dynamic> newMessage = {
          'sender': sender,
          'receiver': receiver,
          'textmessage': textMessage,
        };
        messageController.addMessage(newMessage);
        _textController.clear();
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        print("Sender, receiver, or message is empty.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.data[widget.index]['username']}'),
        backgroundColor: background,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messageController.messages.length,
                itemBuilder: (context, index) {
                  if (messageController.messages[index]['receiver'] ==
                      controller.data[widget.index]['id']) {
                    return Container(
                      color: background,
                      child: ListTile(
                        subtitle: Text(
                          messageController.messages[index]['time'],
                          style: TextStyle(color: white),
                        ),
                        title: Text(
                          messageController.messages[index]['textmessage'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else if (messageController.messages[index]['sender'] ==
                      controller.data[widget.index]['id']) {
                    return Container(
                      color: background,
                      child: ListTile(
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${messageController.messages[index]['textmessage']}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: primecolor,
                              ),
                            ),
                            Text("${messageController.messages[index]['time']}",
                                style: TextStyle(color: primecolor)),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Send a message',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      setState(() {
                        _sendMessage(widget.index);
                        fetchMessages(ID);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PrivateChatPage(widget.index),
                            ));
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
