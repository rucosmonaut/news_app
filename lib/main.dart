import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';

import 'components/news_item.dart';
import 'network/news_network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Spartak News',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<News>? news = [];
  bool loading = true;

  Future<void> _updateNews() async {
    bool isHave = true;
    int page = 0;
    List<News> newsList = [];

    while (isHave) {
      var response = await getNews(page);
      if (response?.news != null) {
        newsList.addAll(response!.news);
        page++;
        isHave = !response.last;
      }
    }

    news = newsList;
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    _updateNews();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    //final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Spartak News'),
        leading: Image.asset("assets/images/logo.png"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height * 0.02,
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: news?.length ?? 0,
                        itemBuilder: (BuildContext context, index) {
                          return Column(
                            children: [
                              NewsItem(
                                news: News(news![index].title,
                                    news![index].text, news![index].date,
                                    isVideo: news![index].isVideo,
                                    image: news![index].image,
                                    video: news![index].video),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                            ],
                          );
                        }),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateNews,
        tooltip: 'Обновить',
        backgroundColor: Colors.black87,
        child: const Icon(Icons.update),
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
