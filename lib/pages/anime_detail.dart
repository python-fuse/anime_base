import 'package:anime_base/data/fetch_anime.dart';
import 'package:anime_base/data/utils.dart';
import 'package:anime_base/models/anime_model.dart';
import 'package:anime_base/widgets/anime_row.dart';
import 'package:anime_base/widgets/genre_card.dart';
import 'package:anime_base/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee/text_marquee.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:anime_base/data/database_helpers.dart';

class AnimeDetail extends StatefulWidget {
  final dynamic anime;
  const AnimeDetail({super.key, required this.anime});

  @override
  State<AnimeDetail> createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> {
  Future<List<AnimeRecommendation>>? recommendedAnime;
  bool _isSaved = false;

  String getAiredYear(String date) {
    List<String> airedDate = date.split(',');

    return airedDate[1].split(' ')[1];
  }

  Future<void> launchURL() async {
    final url = Uri.parse(widget.anime.trailerUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    recommendedAnime = fetchAnimeRecommendation(widget.anime.id);
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final saved = await DatabaseHelper.instance.isAnimeSaved(widget.anime.id);
    setState(() {
      _isSaved = saved;
    });
  }

  Future<void> _toggleSave() async {
    if (_isSaved) {
      await DatabaseHelper.instance.deleteAnime(widget.anime.id);
    } else {
      await DatabaseHelper.instance.saveAnime(widget.anime);
    }
    setState(() {
      _isSaved = !_isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Image.network(
                  widget.anime.largeImageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: getDeviceWidth(context) * 0.68,
                            child: TextMarquee(
                              widget.anime.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: _toggleSave,
                                icon: Icon(
                                  _isSaved
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline,
                                  color: _isSaved ? Colors.deepOrange : null,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.send),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.deepOrange.shade600,
                            size: 18,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            widget.anime.score.toStringAsFixed(1),
                            style: TextStyle(color: Colors.deepOrange.shade600),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            getAiredYear(
                              widget.anime.aired,
                            ),
                          ),
                          const SizedBox(width: 7),
                          Text("Episodes: ${widget.anime.favorites}"),
                          const SizedBox(width: 7),
                          Cube(text: widget.anime.rating),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: launchURL,
                            child: const Button(
                              variant: 'filled',
                              text: "Watch Trailer",
                              icon: Icons.play_circle_fill,
                            ),
                          ),
                          const Button(
                            variant: 'outline',
                            text: "Download",
                            icon: Icons.play_circle_fill,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          for (var genre in widget.anime.genres.split(','))
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: GenreCard(text: genre),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${widget.anime.description.length > 200 ? widget.anime.description.substring(0, 200) : widget.anime.description}...",
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Related Anime",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          recommendedAnime == null
                              ? const Text("No recommendation")
                              : AnimeRow(animeList: recommendedAnime)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            buidBackButton(context),
          ],
        ),
      ),
    );
  }

  GestureDetector buidBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        height: 90,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black38, Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        padding: const EdgeInsets.only(left: 10, top: 16),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class Cube extends StatelessWidget {
  const Cube({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.deepOrange.shade600),
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        text.substring(0, 2),
        style: TextStyle(fontSize: 12, color: Colors.deepOrange.shade600),
      ),
    );
  }
}
