import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MessageController extends GetxController {
  var messages = [].obs;

  void addMessage(Map<String, dynamic> message) {
    messages.add(message);
  }

  void clearMessages() {
    messages.clear();
  }
}