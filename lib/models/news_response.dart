import 'news.dart';

class NewsResponse {
  List<News> news;
  int count;
  bool last;

  NewsResponse(this.news, this.count, this.last);
}
