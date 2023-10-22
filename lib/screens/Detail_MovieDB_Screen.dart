import 'dart:ui';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Fav_Model.dart';
import 'package:flutter_application_3/database/agendadb.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_application_3/assets/models/popular_model.dart';
import 'dart:math';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/counter.dart';
import 'package:flutter_application_3/screens/image_carusel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/HeartCheckbox.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class Actor {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  Actor({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      profilePath: json['profile_path'],
    );
  }
}

class DetailMovieDBScreen extends StatefulWidget {
  const DetailMovieDBScreen({super.key});

  @override
  State<DetailMovieDBScreen> createState() => _DetailMovieDBScreenState();
}

class _DetailMovieDBScreenState extends State<DetailMovieDBScreen> {
  //bool _isFavorited = false;
  final TextStyle commonTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  late YoutubePlayerController _controller;
  AgendaDB? agendaDB;
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<String> fetchMovieTrailerKey(int movieId) async {
    final apiKey =
        '4403bdcf59ccea40c627f74de397e6a0'; // Reemplaza con tu clave de API de TMDb
    final language = 'es-MX';

    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=$language'),
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

  Future<List<Actor>> fetchMovieActors(int movieId) async {
    final apiKey =
        '4403bdcf59ccea40c627f74de397e6a0'; // Reemplaza con tu clave de API de TMDb
    final language = 'es-MX';

    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=$language'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final cast = data['cast'] as List;
      final filteredActors = cast
          .where((actorData) => actorData['known_for_department'] == 'Acting')
          .take(10) // Muestra solo los primeros 10 actores
          .map((actorData) => Actor.fromJson(actorData))
          .toList();
      return filteredActors;
    } else {
      throw Exception('Failed to load movie credits');
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as FavModel;

    // Obtain the trailer key and set the YoutubePlayerController
    fetchMovieTrailerKey(movie.idApi!).then((trailerKey) {
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
    Widget? List1;
    Widget? Favs;
    Favs = ElevatedButton(
      onPressed: () {
        agendaDB!.checkIfMovieExists(movie.idApi!).then((isMovieInFavs) {
          if (isMovieInFavs) {
            // Si la película está en la base de datos, eliminarla
            agendaDB!.DELETE_Fav('tblFav', movie.idApi!).then((value) {
              GlobalValues.flagFavs.value = !GlobalValues.flagFavs.value;
              var msj =
                  (value > 0) ? 'Eliminación exitosa' : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            });
          } else {
            // Si la película no está en la base de datos, agrégala
            agendaDB!.INSERT_Fav('tblFav', {
              'idApi': movie.idApi,
              'originalTitle': movie.originalTitle,
              'overview': movie.overview,
              'posterPath': movie.posterPath,
              'releaseDate': movie.releaseDate,
              'title': movie.title,
              'voteAverage': movie.voteAverage
            }).then((value) {
              GlobalValues.flagFavs.value = !GlobalValues.flagFavs.value;
              var msj = (value > 0) ? 'Inserción exitosa' : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            });
          }
        });
      },
      child: FutureBuilder<bool>(
        future: agendaDB!.checkIfMovieExists(movie.idApi!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Si la película está en la base de datos, muestra "Delete in Favs"
            return Text(snapshot.data! ? 'Delete in Favs' : 'Save in Favs');
          } else {
            // Si hay un error al verificar, muestra un mensaje genérico
            return Text('Save in Favs');
          }
        },
      ),
    );
    try {
      List1 = Container(
        // Espacio entre actores
        decoration: BoxDecoration(
          shape: BoxShape.rectangle, // Forma de círculo
          border: Border.all(
            color: Colors.red, // Color del contorno
            width: 5.0, // Ancho del contorno
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: FutureBuilder<List<Actor>>(
            future: fetchMovieActors(movie.idApi!),
            builder: (context, snapshot) {
              final actors = snapshot.data ?? [];
              if (actors.length == 10) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      children: actors.map((actor) {
                        return Padding(
                          padding: EdgeInsets.only(right: 5.0, left: 5.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, // Forma de círculo
                                  border: Border.all(
                                    color: Colors.red, // Color del contorno
                                    width: 2.0, // Ancho del contorno
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                actor.name,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                actor.character,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              } else if (actors.length < 10) {
                return CircularProgressIndicator();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      );
    } catch (e) {
      List1 = Text('');
    }

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
      } else {
        videoPlayer = Text(
          'Trailer de la Pelicula no disponible :(',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        );
      }
    } catch (e) {
      videoPlayer = Text('');
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
                Navigator.pushNamed(context, '/Favs');
              },
            ),
          ],
        ),
        actions: <Widget>[
          Favs,
          SizedBox(width: 20.0),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Hero(
        tag: 'moviePoster${movie.idApi}',
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
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
                        width: 500,
                        //height: 1000,
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
                                  movie.title!,
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  movie.overview!,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 10.0),
                                Text('Movie ID: ${movie.idApi}',
                                    style: commonTextStyle),
                                SizedBox(height: 10.0),
                                Text('Original Title: ${movie.originalTitle}',
                                    style: commonTextStyle),
                                SizedBox(height: 10.0),
                                Text('${movie.releaseDate}',
                                    style: commonTextStyle),
                                SizedBox(height: 10.0),
                                Text('Rating: ${movie.voteAverage!.ceil()}',
                                    style: commonTextStyle),
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: movie.voteAverage!,
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
                                SizedBox(height: 10.0),
                                Text(
                                  'Actors',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 10.0),
                                List1,
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
      ),
    );
  }
}
