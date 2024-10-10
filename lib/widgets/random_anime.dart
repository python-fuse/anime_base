import 'package:anime_base/models/anime_model.dart';
import 'package:anime_base/widgets/top_anime_card.dart';
import 'package:flutter/material.dart';

class RandomAnime extends StatefulWidget {
  final Future<List<Anime>>? animeList;
  const RandomAnime({super.key, required this.animeList});

  @override
  State<RandomAnime> createState() => _RandomAnimeState();
}

class _RandomAnimeState extends State<RandomAnime> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.animeList,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return TopAnimeCard(animeList: snapshot.data as List<Anime>);
          } else {
            return const Dialog(
              child: Text('Error fetching data'),
            );
          }
        });
  }
}
