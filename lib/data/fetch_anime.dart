import 'dart:convert';
import 'package:anime_base/data/constants.dart';
import 'package:anime_base/models/anime_model.dart';
import 'package:http/http.dart' as http;

Future<List<Anime>> fetchPopularAnime() async {
  final response = await http.get(Uri.parse('${API_URL}top/anime'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    if (jsonData['data'] != null && jsonData['data'] is List) {
      return jsonData['data']
          .map<Anime>((json) => Anime.fromJson(json))
          .toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load anime: ${response.body}');
  }
}

Future<List<Anime>> fetchTrendingAnime() async {
  final response = await http.get(Uri.parse('${API_URL}top/anime?&page=2'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    if (jsonData['data'] != null && jsonData['data'] is List) {
      return jsonData['data']
          .map<Anime>((json) => Anime.fromJson(json))
          .toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load anime: ${response.body}');
  }
}

Future<List<AnimeRecommendation>> fetchAnimeRecommendation(int id) async {
  final response = await http
      .get(Uri.parse('${API_URL}anime/$id/recommendations?page=1&limit=5'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    if (jsonData['data'] != null && jsonData['data'] is List) {
      print(jsonData['data'].length);
      return jsonData['data']
          .map<AnimeRecommendation>(
              (json) => AnimeRecommendation.fromJson(json['entry']))
          .toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load anime: ${response.body}');
  }
}
