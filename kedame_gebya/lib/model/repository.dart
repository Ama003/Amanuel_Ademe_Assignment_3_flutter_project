import 'dart:convert';
import 'model.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  Future<List?> fetchActivity() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return KedameGebya.kedameGebyaList(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
