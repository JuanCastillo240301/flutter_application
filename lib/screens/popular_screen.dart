import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/models/popular_model.dart';
import 'package:flutter_application_3/network/api_popular.dart';
import 'package:flutter_application_3/widgets/item_movie_widget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  ApiPopular? apiPopular;
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return itemMoviewidget(snapshot.data![index]);
              },
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Algo salió mal :()'));
            } else {
              return CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}
