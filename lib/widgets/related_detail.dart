import 'package:anime_base/data/fetch_anime.dart';
import 'package:anime_base/data/utils.dart';
import 'package:anime_base/models/anime_model.dart';
import 'package:anime_base/widgets/anime_row.dart';
import 'package:anime_base/widgets/genre_card.dart';
import 'package:anime_base/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee/text_marquee.dart';
import 'package:url_launcher/url_launcher.dart';

class RelatedDetail extends StatefulWidget {
  final dynamic anime;
  const RelatedDetail({super.key, required this.anime});

  @override
  State<RelatedDetail> createState() => _RelatedDetailState();
}

class _RelatedDetailState extends State<RelatedDetail> {
  Future<Anime>? recommendedAnime;

  @override
  void initState() {
    super.initState();
    recommendedAnime = fetchAnimeDetail(widget.anime.id);
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder(
            future: recommendedAnime,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Image.network(
                          snapshot.data!.largeImageUrl,
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
                                    width: getDeviceWidth(context) * 0.69,
                                    child: TextMarquee(
                                      snapshot.data!.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.bookmark_add_outlined),
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
                                    snapshot.data!.score.toStringAsFixed(1),
                                    style: TextStyle(
                                        color: Colors.deepOrange.shade600),
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    getAiredYear(
                                      snapshot.data!.aired,
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Text("Episodes: ${snapshot.data!.favorites}"),
                                  const SizedBox(width: 7),
                                  Cube(text: snapshot.data!.rating),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  for (var genre
                                      in snapshot.data!.genres.split(','))
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: GenreCard(text: genre),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${snapshot.data!.description.length > 200 ? snapshot.data!.description.substring(0, 200) : snapshot.data!.description}...",
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 20),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     const Text(
                              //       "Related Anime",
                              //       style: TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //     const SizedBox(height: 3),
                              //     recommendedAnime == null
                              //         ? const Text("No recommendation")
                              //         : AnimeRow(animeList: recommendedAnime)
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                    buidBackButton(context),
                  ],
                );
              } else {
                return Scaffold(
                    appBar: AppBar(),
                    body: Center(
                      child: Text('Error fetching data'),
                    ));
              }
            }),
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
