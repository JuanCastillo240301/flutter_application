import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Tarea_model.dart';
//import 'package:flutter_application_3/assets/models/Carrera_model.dart';
//import 'package:flutter_application_3/assets/models/Profesor_model.dart';
import 'package:flutter_application_3/database/schooldb.dart';
import 'package:flutter_application_3/widgets/CardTareaWidget.dart';
import 'package:flutter_application_3/widgets/CardTaskWidget.dart';
//import 'package:flutter_application_3/widgets/CardProfesorWidget.dart';

class TareaScreen extends StatefulWidget {
  const TareaScreen({Key? key}) : super(key: key);

  @override
  State<TareaScreen> createState() => _TareaScreenState();
}

class _TareaScreenState extends State<TareaScreen> {
  TextEditingController _searchController = TextEditingController();
  SchoolDB? schoolDB;
  String _selectedEstado = 'Todas';
  List<TareaModel> _tasks = [];

  @override
  void initState() {
    super.initState();
    schoolDB = SchoolDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea Manager'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.search),
          ),
          DropdownButton<String>(
            value: _selectedEstado,
            onChanged: (String? newValue) {
              setState(() {
                _selectedEstado = newValue!;
                // Llamar a la función para actualizar la lista de tareas
                _updateTaskList();
                GlobalValues.flagTarea.value = !GlobalValues.flagTarea.value;
              });
            },
            items: <String>['Todas', 'Pendiente', 'Completado']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/add_Tarea').then((value) {
                    setState(() {});
                  }),
              icon: Icon(Icons.task))
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
        valueListenable: GlobalValues.flagTarea,
        builder: (context, value, _) {
          return FutureBuilder(
            future: _searchController.text.isEmpty
                ? schoolDB!.GETALLTASK3()
                : schoolDB!.GET_TareaByName(_searchController.text),
            builder: (BuildContext context,
                AsyncSnapshot<List<TareaModel>> snapshot) {
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
                  itemCount: _tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardTareaWidget(
                      tareaModel: _tasks[index],
                      schoolDB: schoolDB,
                    );
                  },
                );
              } else {
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

  Future<void> _updateTaskList() async {
    List<TareaModel> tasks;
    if (_selectedEstado == 'Todas') {
      tasks = await schoolDB!.GETALLTASK3();
      GlobalValues.flagTarea.value = !GlobalValues.flagTarea.value;
    } else {
      tasks = await schoolDB!.GET_TareaByEstado(_selectedEstado);
      GlobalValues.flagTarea.value = !GlobalValues.flagTarea.value;
    }

    setState(() {
      // Actualizar la lista de tareas
      _tasks = tasks;
    });
  }
}
