import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/models/Fav_Model.dart';
import 'package:flutter_application_3/database/agendadb.dart';
//import 'package:flutter_application_3/network/api_popular.dart';
import 'package:flutter_application_3/widgets/movie_cell_widget_DB.dart';

class FavsScreen extends StatefulWidget {
  const FavsScreen({super.key});

  @override
  State<FavsScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<FavsScreen> {
  //ApiPopular? apiPopular;
  AgendaDB? agendaDB;
  @override
  void initState() {
    super.initState();
    //apiPopular = ApiPopular();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
        leading: Row(
          children: <Widget>[
            SizedBox(width: 5.0),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/dash');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: agendaDB!.GETALLMovies(),
        builder: (context, AsyncSnapshot<List<FavModel>?> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.67,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/detailMovieDB',
                      arguments: snapshot.data![index]),
                  child: MovieCellDB(snapshot.data![index]),
                );
              },
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Algo salió mal :()'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}
