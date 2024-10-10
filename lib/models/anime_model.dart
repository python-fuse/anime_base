class Anime {
  final int id;
  final String title;
  final String imageUrl;
  final String largeImageUrl;
  final String description;
  final String rating;
  final String type;
  final int episodes;
  final String status;
  final String trailerUrl;
  final String aired;
  final String duration;
  final double score;
  final int rank;
  final int popularity;
  final int members;
  final int favorites;
  final String premiered;
  final String genres;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.largeImageUrl,
    required this.description,
    required this.rating,
    required this.type,
    required this.episodes,
    required this.status,
    required this.aired,
    required this.duration,
    required this.trailerUrl,
    required this.score,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.premiered,
    required this.genres,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'] ?? 0,
      title: json['title_english'] ?? '',
      imageUrl: json['images']['jpg']['image_url'] ?? '',
      largeImageUrl: json['images']['jpg']['large_image_url'] ?? '',
      description: json['synopsis'] ?? '',
      rating: json['rating'] ?? '',
      type: json['type'] ?? '',
      trailerUrl: json['trailer']['url'] ?? '',
      episodes: json['episodes'] ?? 0,
      status: json['status'] ?? '',
      aired: json['aired']['string'] ?? '',
      duration: json['duration'] ?? '',
      score: (json['score'] ?? 0).toDouble(),
      rank: json['rank'] ?? 0,
      popularity: json['popularity'] ?? 0,
      members: json['members'] ?? 0,
      favorites: json['favorites'] ?? 0,
      premiered: json['premiered'] ?? '',
      genres: (json['genres'] as List<dynamic>)
          .map((genre) => genre['name'])
          .join(', '),
    );
  }
}

class AnimeRecommendation {
  final int id;
  final String title;
  final String imageUrl;
  final String largeImageUrl;
  final String url;
  final int votes;

  AnimeRecommendation({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.largeImageUrl,
    required this.url,
    required this.votes,
  });

  factory AnimeRecommendation.fromJson(Map<String, dynamic> json) {
    return AnimeRecommendation(
      id: json['mal_id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['images']['jpg']['image_url'] ?? '',
      largeImageUrl: json['images']['jpg']['large_image_url'] ?? '',
      url: json['url'] ?? '',
      votes: json['votes'] ?? 0,
    );
  }
}
