import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/database/schooldb.dart';
import 'package:flutter_application_3/widgets/CardCarreraWidget.dart';

import '../assets/models/Carrera_model.dart';

class CarreraScreen extends StatefulWidget {
  const CarreraScreen({Key? key}) : super(key: key);

  @override
  State<CarreraScreen> createState() => _CarreraScreenState();
}

class _CarreraScreenState extends State<CarreraScreen> {
  TextEditingController _searchController = TextEditingController();
  SchoolDB? schoolDB;

  @override
  void initState() {
    super.initState();
    schoolDB = SchoolDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrera Manager'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.search),
          ),
           IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/add_Carrera')
              .then((value){
                setState(() {});
              }
            ), 
            icon: Icon(Icons.task)
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a career',
              ),
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagCarrera,
        builder: (context, value, _) {
          return FutureBuilder(
            future: _searchController.text.isEmpty
                ? schoolDB!.GETALLTASK()
                : schoolDB!.GET_CareerByName(_searchController.text),
            builder: (BuildContext context, AsyncSnapshot<List<CarreraModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error!'),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardCarreraWidget(
                      carreraModel: snapshot.data![index],
                      schoolDB: schoolDB,
                    );
                  },
                );
              } else  {
    var msj = 'NO SE ENCONTRARON DATOS';
    var snackbar = SnackBar(content: Text(msj));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    return Container(); // container in this case
    
  }
            },
          );
        },
      ),
    );
  }
}