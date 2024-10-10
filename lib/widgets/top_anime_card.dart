import 'package:anime_base/data/utils.dart';
import 'package:anime_base/models/anime_model.dart';
import 'package:flutter/material.dart';

class TopAnimeCard extends StatefulWidget {
  final List<Anime> animeList;
  const TopAnimeCard({Key? key, required this.animeList}) : super(key: key);

  @override
  State<TopAnimeCard> createState() => _TopAnimeCardState();
}

class _TopAnimeCardState extends State<TopAnimeCard> {
  bool _isExpanded = false;
  static const int _maxLines = 3;
  static const int _maxCharacters = 100;
  late Anime anime;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    anime = pickRandomAnime(widget.animeList);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: getDeviceHeight(context) * 0.5,
          width: getDeviceWidth(context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(anime.largeImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: getDeviceHeight(context) * 0.5,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                anime.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  final span = TextSpan(
                    text: anime.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  );
                  final tp = TextPainter(
                    text: span,
                    maxLines: _maxLines,
                    textDirection: TextDirection.ltr,
                  );
                  tp.layout(maxWidth: constraints.maxWidth);

                  if (tp.didExceedMaxLines ||
                      anime.description.length > _maxCharacters) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          !_isExpanded
                              ? anime.description
                              : '${anime.description.substring(0, _maxCharacters)}...',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: _isExpanded ? null : _maxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                        GestureDetector(
                          onTap: _toggleExpand,
                          child: Text(
                            !_isExpanded ? 'Read less' : 'Read more',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      anime.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
