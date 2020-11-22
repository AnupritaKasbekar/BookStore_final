import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'Post_model.dart';
import 'package:http/http.dart' as http;
import 'SearchData.dart';

class HttpService {
  bool isData = false;
  List<String> JsonInList;
  var jsonMap;

  Future<Post> get dataToList => null;

  Future<Post> getPosts() async {
    //final String postUrl = "https://api.itbook.store/1.0/search/mongodb";
    final String postUrl = "https://api.itbook.store/1.0/search/new";
    var client = http.Client();
    try {
      var res = await client.get(postUrl);
      if (res.statusCode == 200) {
        return Post.fromJson(jsonDecode(res.body));
      }
    } catch (Exception) {}
  }
}
