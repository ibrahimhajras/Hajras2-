import 'package:get/get.dart';

import '../link/link.dart';
import 'crud.dart';
class HomeController extends GetxController {
  var data = [].obs;
  var selectedValue = "Edit".obs;
  Crud _crud = Crud();

  @override
  void onInit() {
    update();
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    var result = await _crud.getRequest(Linkshow);
    data.assignAll(result['data']);
  }

  void onItemSelected(value) {
    selectedValue.value = value;
  }
}
class SwitchController extends GetxController {
  var switchState = false.obs;
  void toggleSwitch(bool value) {
    switchState.value = value;
  }
}


class SubjectUserController extends GetxController {
  var data1 = [].obs;
  Crud _crud = Crud();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    var result1 = await _crud.getRequest(LinkadShowSubject);
    data1.assignAll(result1['data']);
  }
}
