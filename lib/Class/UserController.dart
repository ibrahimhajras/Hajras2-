import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../link/link.dart';
import 'crud.dart';

class UserController extends GetxController {
  var dataList = [].obs;
  Crud _crud = Crud();


  void fetchDataUserList(String id) async {
    try {
      var response = await _crud.postRequest(LinkUserList, {'id': id});
      if (response is Map<String, dynamic>) {
        if (response.containsKey('status') && response['status'] == 's') {
          if (response.containsKey('data')) {
            dataList.value = response['data'];
            print(response['data']);
          } else {
            print('Data key not found in the response');
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
}