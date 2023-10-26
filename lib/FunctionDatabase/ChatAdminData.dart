import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart' as http;

import '../Class/crud.dart';
import '../link/link.dart';
Crud _crud = Crud();
 sendMessageToDatabase(String sender, String receiver, String textMessage) async {
  var response = await _crud.postRequest(LinkChatAdmin, {
    'sender': sender,
    'receiver': receiver,
    'textmessage': textMessage,
  });
  if (response != null) {
    if (response['status'] == 's') {
      print('Message sent successfully.');
    } else {
      print('Failed to send message.');
    }
  } else {
    print('Failed to receive a valid response.');
  }
}

 fetchDataFromServer(String sender, String receiver) async {
  try {
    Map<String, dynamic> response = await _crud.postRequest(LinkShowMessage, {
      'sender': sender,
      'receiver': receiver,
    });
    print(response);
    return response;
  } catch (e) {
    print('Error fetching data: $e');
    throw e;
  }
}








