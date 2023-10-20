import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/models/popular_model.dart';
import 'dart:math';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/models/popular_model.dart';
import 'package:flutter_application_3/screens/counter.dart';
import 'package:flutter_application_3/screens/image_carusel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/models/popular_model.dart';
import 'package:flutter_application_3/widgets/HeartCheckbox.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  bool _isFavorited = false;
  final TextStyle commonTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<String> fetchMovieTrailerKey(int movieId) async {
    final apiKey = '4403bdcf59ccea40c627f74de397e6a0'; // Reemplaza con tu clave de API de TMDb
    final language = 'es-MX';

    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=$language'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      for (final video in results) {
        if (video['type'] == 'Trailer' && video['site'] == 'YouTube') {
          return video['key'];
        }
      }
    }

    // Handle if no trailer is found
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as PopularModel;

    // Obtain the trailer key and set the YoutubePlayerController
    fetchMovieTrailerKey(movie.id).then((trailerKey) {
      setState(() {
        _controller = YoutubePlayerController(
          initialVideoId: trailerKey,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
          ),
        );
      });
    });
    Widget? videoPlayer;
try {
  if (_controller.initialVideoId != '') {
  videoPlayer = YoutubePlayer(
    controller: _controller,
    actionsPadding: const EdgeInsets.only(left: 16.0),
    bottomActions: [
      CurrentPosition(),
      const SizedBox(width: 10.0),
      ProgressBar(isExpanded: true),
      const SizedBox(width: 10.0),
      RemainingDuration(),
    ],
  );
  }else{
     videoPlayer =  Text(
                                'Trailer de la Pelicula no disponible',
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              );
  }
} catch (e) {
  videoPlayer = Text('Ocurrió un error al cargar el reproductor de video.');
}

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Detalle de la Película'),
        backgroundColor: Colors.transparent,
        leading: Row(
          children: <Widget>[
            SizedBox(width: 5.0),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: <Widget>[
          CustomCheckbox(
            value: _isFavorited,
            onChanged: (bool? newValue) {
              setState(() {
                _isFavorited = newValue ?? true;
              });
            },
          ),
          SizedBox(width: 20.0),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Mostrar la imagen de la película si lo deseas.
                    SizedBox(height: 30.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      //height: 600,
                      width: 500,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              videoPlayer,
                              SizedBox(height: 20.0),
                              Text(
                                movie.title,
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                movie.overview,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10.0),
                              Text('Original Title: ${movie.id}', style: commonTextStyle),
                              SizedBox(height: 10.0),
                              Text('Original Title: ${movie.originalTitle}', style: commonTextStyle),
                              SizedBox(height: 10.0),
                              Text('Release Date: ${DateFormat('dd-MM-yyyy').format(movie.releaseDate)}', style: commonTextStyle),
                              SizedBox(height: 10.0),
                              Text('Rating: ${movie.voteAverage.ceil()}', style: commonTextStyle),
                              RatingBar.builder(
                                initialRating: movie.voteAverage,
                                minRating: 0.5,
                                direction: Axis.horizontal,
                                itemCount: 10,
                                itemSize: 20,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                                tapOnlyMode: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}