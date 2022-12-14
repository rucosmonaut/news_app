import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/components/news_card.dart';
import 'package:news_app/models/news.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;
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

    return Container(
      width: width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.9)),
      child: Column(
        children: [
          Center(
            child: Text(
              news.title,
              style: const TextStyle(
                color: Colors.white38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [getNewsIconWidget()],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat().format(
                  DateTime.fromMillisecondsSinceEpoch(news.date),
                ),
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              OutlinedButton(
                style: const ButtonStyle(enableFeedback: true),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => NewsCard(news: news)),
                    ),
                  );
                },
                child: const Text('Подробнее'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
