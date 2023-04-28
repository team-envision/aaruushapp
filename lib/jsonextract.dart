import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getNameFromAPI() async {
  final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=tesla&from=2023-03-15&sortBy=publishedAt&apiKey=d69969ceb0a14bdc8a685edd73705682'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, parse the JSON response.
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String name = data['name'];
    return name;
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to load data');
  }
}
