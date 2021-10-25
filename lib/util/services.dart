import 'package:http/http.dart' as http;

Future<String> sendHttpRequest(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return (response.body);
  } else {
    throw Exception('Fail to load album');
  }
}
