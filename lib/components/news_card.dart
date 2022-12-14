import 'package:flutter_html/flutter_html.dart';

import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    Widget getNewsIconWidget() {
      YoutubePlayerController controller = YoutubePlayerController(
        initialVideoId: news.video ?? "2U76x2fD_tE",
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );

      if (news.isVideo) {
        return YoutubePlayer(
          width: width * 0.9 - 20,
          controller: controller,
          showVideoProgressIndicator: true,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        );
      }

      return FadeInImage(
        image: NetworkImage("https://static.spartak.com/m/${news.image}"),
        placeholder: const AssetImage("assets/images/loading.gif"),
        imageErrorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Image(
              image: AssetImage("assets/images/no-image.png"),
              fit: BoxFit.fitWidth,
              width: 200,
            ),
          );
        },
        fit: BoxFit.fitWidth,
        width: width * 0.9 - 20,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Spartak News'),
        leading: Image.asset("assets/images/logo.png"),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: const Icon(Icons.arrow_back_rounded))
        ],
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Card(
        child: Row(
          children: [
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: SizedBox(
                width: width * 0.9,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          news.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getNewsIconWidget(),
                      const SizedBox(
                        height: 10,
                      ),
                      Html(data: news.text),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
