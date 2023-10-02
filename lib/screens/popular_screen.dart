import 'package:flutter/material.dart';
import 'package:flutter_application_3/network/api_popular.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
        builder: (context, snapshot) {
          return Text('Hola');
        },
      ),
    );
  }
}
