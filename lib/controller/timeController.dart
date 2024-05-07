import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class DateTimeController extends GetxController{
  void sendDateTimeToServer() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDateTime = formatter.format(now);

    final url = Uri.parse('https://663077fcc92f351c03d9ee40.mockapi.io/apitest/Date');
    final response = await http.post(
      url,
      body: jsonEncode({'date': formattedDateTime}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print('Date and time sent successfully');
    } else {
      print(formattedDateTime);
      print('Failed to send date and time. Error: ${response.reasonPhrase}');
    }
  }

}