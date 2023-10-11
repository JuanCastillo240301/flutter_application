import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/models/popular_model.dart';

Widget itemMoviewidget(PopularModel movie) {
  return FadeInImage(
      fit: BoxFit.fill,
      fadeInDuration: const Duration(milliseconds: 500),
      placeholder: const AssetImage('assets/icon1.png'),
      image:
          NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}'));
}
