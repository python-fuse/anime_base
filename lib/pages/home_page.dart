import 'package:anime_base/data/fetch_anime.dart';
import 'package:anime_base/models/anime_model.dart';
import 'package:anime_base/widgets/popular_anime.dart';
import 'package:anime_base/widgets/random_anime.dart';
import 'package:anime_base/widgets/top_anime.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Anime>>? animeList;

  @override
  void initState() {
    super.initState();
    animeList = fetchPopularAnime();
  }

  Future<void> handleRefresh() async {
    setState(() {
      animeList = fetchPopularAnime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Image.asset(
            'assets/anime.webp',
            width: 50,
            height: 50,
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white, size: 30),
            ),
          ],
        ),
        body: LiquidPullToRefresh(
          onRefresh: handleRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                RandomAnime(animeList: animeList),
                TopAnime(
                  animeList: animeList,
                ),
                const PopularAnime()
              ],
            ),
          ),
        ));
  }
}
