import 'dart:convert';
import 'package:anime_base/data/constants.dart';
import 'package:anime_base/models/anime_model.dart';
import 'package:http/http.dart' as http;

Future<List<Anime>> fetchPopularAnime() async {
  final response = await http.get(Uri.parse('${apiURL}top/anime'));

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
  final response = await http.get(Uri.parse('${apiURL}top/anime?&page=2'));

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
      .get(Uri.parse('${apiURL}anime/$id/recommendations?page=1&limit=5'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    if (jsonData['data'] != null && jsonData['data'] is List) {
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

Future<List<Anime>> fetchAnimeSearch(String query) async {
  final response =
      await http.get(Uri.parse('${apiURL}anime?q=$query&limit=24'));

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

Future<Anime> fetchAnimeDetail(int id) async {
  final response = await http.get(Uri.parse('${apiURL}anime/$id'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return Anime.fromJson(jsonData['data']);
  } else {
    throw Exception('Failed to load anime: ${response.body}');
  }
}
