import 'dart:convert';
import 'package:http/http.dart' as http;

class Crud { // create read update delete
   getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  postRequest(String url,Map data) async {
    try {
      var response = await http.post(Uri.parse(url),body: data);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
