import 'package:anime_base/data/database_helpers.dart';
import 'package:anime_base/models/anime_model.dart';
import 'package:anime_base/widgets/anime_card.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  late Future<List<Anime>> _savedAnimes;

  @override
  void initState() {
    super.initState();
    _savedAnimes = DatabaseHelper.instance.getSavedAnimes();
  }

  Future<void> handleRefresh() async {
    setState(() {
      _savedAnimes = DatabaseHelper.instance.getSavedAnimes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My List"),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: handleRefresh,
        child: FutureBuilder(
          future: _savedAnimes,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Column(
                children: [
                  Text('No saved animes'),
                  Text('Pull down to refresh'),
                ],
              ));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final anime = snapshot.data![index];
                      return AnimeCard(anime: anime);
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
