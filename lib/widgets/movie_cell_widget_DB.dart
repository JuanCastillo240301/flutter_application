import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/models/Fav_Model.dart';
//import 'package:flutter_application_3/assets/models/popular_model.dart';

class MovieCellDB extends StatelessWidget {
  final FavModel movie;

  MovieCellDB(this.movie);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'moviePoster${movie.idApi}',
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.9),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 500),
              placeholder: AssetImage('assets/CircularRed.gif'),
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                color: Colors.red.withOpacity(0.5),
                child: Text(
                  movie.title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
