import 'package:anime_base/data/fetch_anime.dart';
import 'package:anime_base/models/anime_model.dart';
import 'package:anime_base/widgets/anime_row.dart';
import 'package:flutter/material.dart';

class PopularAnime extends StatefulWidget {
  const PopularAnime({super.key});

  @override
  State<PopularAnime> createState() => _PopularAnimeState();
}

class _PopularAnimeState extends State<PopularAnime> {
  Future<List<Anime>>? trendingAnimeList;

  @override
  void initState() {
    super.initState();

    trendingAnimeList = fetchTrendingAnime();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Trending",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          AnimeRow(
            animeList: trendingAnimeList,
          )
        ],
      ),
    );
  }
}
