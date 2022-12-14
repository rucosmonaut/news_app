class News {
  String title;
  String text;
  int date;
  String? image;
  String? video;
  bool isVideo;

  News(this.title, this.text, this.date,
      {this.image, this.isVideo = false, this.video});
}
