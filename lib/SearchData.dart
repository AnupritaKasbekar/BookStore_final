import 'Post_model.dart';
import 'http_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class SearchData {
  static List<Post> bookList = [];
  static List<String> bookString = [];

  static Future<List<Post>> loadBookList() async {
    print("In loadBookList");
    final String postUrl = "https://api.itbook.store/1.0/search/new";
    var client = http.Client();
    try {
      var res = await client.get(postUrl);

      print(res);
      if (res.statusCode == 200) {
        bookList = new List<Post>();

        String jsonString = (await http.get(postUrl)) as String;

        Map<String, dynamic> body = json.decode(res.body);

        Post post = Post.fromJson(body);

        bookList.add(post);
      }
    } catch (Exception) {}
    return bookList;
  }
}
