import 'dart:math';

import 'package:anime_base/models/anime_model.dart';
import 'package:flutter/material.dart';

double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Anime pickRandomAnime(List<Anime> animeList) {
  int randomIndex = Random().nextInt(animeList.length);
  return animeList[randomIndex];
}
