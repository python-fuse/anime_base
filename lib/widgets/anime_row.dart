import 'package:anime_base/models/anime_model.dart';
import 'package:anime_base/widgets/anime_card.dart';
import 'package:anime_base/widgets/related_card.dart';
import 'package:flutter/material.dart';

class AnimeRow extends StatelessWidget {
  final Future<List<dynamic>>? animeList;
  const AnimeRow({super.key, required this.animeList});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: animeList,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, index) {
                  return snapshot.data.runtimeType == (List<Anime>)
                      ? AnimeCard(
                          anime: snapshot.data![index],
                        )
                      : RelatedCard(
                          anime: snapshot.data![index],
                        );
                },
              ),
            );
          } else {
            return const SizedBox(
              width: double.infinity,
              height: 100,
              child: Text('Error fetching data'),
            );
          }
        });
  }
}
