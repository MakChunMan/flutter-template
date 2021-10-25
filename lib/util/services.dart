import 'package:http/http.dart' as http;

Future<> sendHttpRequest(string url) async {
  final response = await http.get(Uri.parse(url));

  if(reusonse.statusCode == 200){
    return(response.body)
  } else {
    throw Exception('Fail to load album');
  }
}