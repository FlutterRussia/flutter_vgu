import 'dart:async';
import 'dart:convert';

import 'package:flutter_vgu/models/news_model.dart';
import 'package:http/http.dart' as http;

String cntry = 'us';

final _apiKey = '53ea041b1e1c4c659b41767532da63f2';

StreamController controller = StreamController<NewsModel>();

Future getData() async {
  String url = "https://newsapi.org/v2/top-headlines?country=$cntry&apiKey=$_apiKey";

  final response = await http.get(url);
  if (response.statusCode == 200) {
    controller.sink.add(NewsModel.fromJson(json.decode(response.body)));
  } else {
    throw Exception("Faild to post!");
  }
}
