 import 'package:http/http.dart' as http;
Future<void> checkConditionAndPerformAction() async {
  final response = await http.get(Uri.parse('https://663077fcc92f351c03d9ee40.mockapi.io/apitest/Date'));
  if (response.statusCode == 200) {
    final bool condition = response.body== 'true'; // Assumibng server responds with 'true' or 'false'
    if (condition) {
      print('hello');
    }else {
      print('fuck');
    }
    }
  }

