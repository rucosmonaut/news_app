import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news.dart';
import 'package:news_app/models/news_response.dart';

Future<NewsResponse?> getNews(int page) async {
  List<News> newsList = [];
  var url = Uri.parse(
      'https://spartak.com/json/query/webAllNews?variant=webDefaultJs.json&count=100&direction=desc&field=date&page=$page&video=true');
  var response = await http.get(url, headers: {'Accept': 'application/json'});
  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body.toString());
    var count = responseBody['count'];
    var last = responseBody['last'];
    var list = responseBody['list'] as List;
    for (var item in list) {
      if (item["type"] == "video") {
        News news = News(item["title"], item["text"], item["date"],
            isVideo: true, video: item["hostingId"]);
        newsList.add(news);
      } else {
        News news =
            News(item["title"], item["text"], item["date"], isVideo: false);
        if (item["gallery"] != null) {
          if ((item["gallery"] as List).isNotEmpty) {
            news.image = (item["gallery"] as List)[0];
          }
        }

        newsList.add(news);
      }
    }

    NewsResponse newsResponse = NewsResponse(newsList, count, last);

    return newsResponse;
  } else {
    return null;
  }
}
