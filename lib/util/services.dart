import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';
import 'wppage_menu_model.dart';
import 'app_config.dart';

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  String removeTabFromWPString(String s) {
    String aStr = s.replaceAll("&#8220;", '"');
    aStr = aStr.replaceAll("\n<p>", "");
    aStr = aStr.replaceAll("</p>\n", "");
    aStr = aStr.replaceAll("&#8221;", '"');
    aStr = aStr.replaceAll("&#8243;", '"');
    return aStr;
  }

  Future<Rendered> getWPPage() async {
    Response res = await get(Uri.parse("https://flutter-backend.imagworkshop.com/wp-json/wp/v2/pages/52?_fields=id,content"));
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);

      String aStr = removeTabFromWPString(map['content']['rendered']);
      print(aStr);
      Rendered body = Rendered.fromJson(jsonDecode(aStr));

      String hostURL = AppConfig.forEnvironment().propertiesMap["apiUrl"];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List> getPosts() async {
    Response res = await get(Uri.parse(postsURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<void> deletePost(int id) async {
    Response res = await delete(Uri.parse("$postsURL/$id"));

    if (res.statusCode == 200) {
      print("DELETED");
    } else {
      throw "Unable to delete post.";
    }
  }

  retryFuture(future, delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      future();
    });
  }
}
