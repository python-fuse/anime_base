import 'package:anime_base/models/anime_model.dart';
import 'package:anime_base/widgets/anime_row.dart';
import 'package:flutter/material.dart';

class TopAnime extends StatefulWidget {
  final Future<List<Anime>>? animeList;
  const TopAnime({super.key, required this.animeList});

  @override
  State<TopAnime> createState() => _TopAnimeState();
}

class _TopAnimeState extends State<TopAnime> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Spotlight",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          AnimeRow(
            animeList: widget.animeList,
          )
        ],
      ),
    );
  }
}
