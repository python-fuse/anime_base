import 'package:flutter/material.dart';
import 'package:anime_base/data/fetch_anime.dart';
import 'package:anime_base/models/anime_model.dart';
import 'package:anime_base/widgets/anime_card.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  List<Animation<double>> _animations = [];
  TextEditingController promptController = TextEditingController();
  Future<List<Anime>>? searchResults;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String prompt, int resultCount) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'search_results_channel',
      'Search Results',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      enableVibration: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Search Results Available',
      'Found $resultCount results for "$prompt"',
      platformChannelSpecifics,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchResults = fetchAnimeSearch(query);
        searchResults!.then((results) {
          _showNotification(query, results.length);
          _setupAnimations(results.length);
        });
      });
    }
  }

  void _setupAnimations(int itemCount) {
    _animations = List.generate(
      itemCount,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (index / itemCount) / 2,
            ((index + 1) / itemCount) / 2,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchBar(
              controller: promptController,
              padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
              hintText: 'Search for anime',
              hintStyle: const MaterialStatePropertyAll(
                TextStyle(color: Colors.grey, fontSize: 12),
              ),
              textStyle: const MaterialStatePropertyAll(
                TextStyle(fontSize: 12),
              ),
              onSubmitted: handleSearch,
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Anime>>(
              future: searchResults,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final List<Anime> results = snapshot.data!;
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                      ),
                      shrinkWrap: true,
                      itemCount: results.length,
                      itemBuilder: (ctx, index) {
                        final Anime anime = results[index];
                        return AnimatedBuilder(
                          animation: _animations[index],
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                  0, 50 * (1 - _animations[index].value)),
                              child: Opacity(
                                opacity: _animations[index].value,
                                child: child,
                              ),
                            );
                          },
                          child: AnimeCard(anime: anime),
                        );
                      },
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Center(child: Text('Search for anime')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
