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

  @override
  void initState() {
    super.initState();
    GlobalValues.flagTarea.value = !GlobalValues.flagTarea.value;
    schoolDB = SchoolDB();
    _selectedEstado = 'Todas';
    updateTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/School');  // Navega hacia atrás al presionar el botón
          },
        ),
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
                updateTaskList();
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
            onPressed: () async {
              await Navigator.pushNamed(context, '/add_Tarea');
              // Llamar a updateTaskList después de agregar una tarea
              updateTaskList();
            },
            icon: Icon(Icons.task),
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
        valueListenable: GlobalValues.flagTarea,
        builder: (context, value, _) {
          return FutureBuilder<List<TareaModel>>(
           future: () {
  if (_searchController.text.isEmpty && _selectedEstado == 'Todas') {
    return schoolDB!.GETALLTASK3();
  } else if (_searchController.text.isEmpty && _selectedEstado != 'Todas') {
    return schoolDB!.GET_TareaByEstado(_selectedEstado);
  } else if (_searchController.text.isNotEmpty && _selectedEstado != 'Todas') {
    return schoolDB!.GET_TareaByNameandEstado(_searchController.text, _selectedEstado);
  }
  // En caso de que ninguna de las condiciones anteriores se cumpla, puedes retornar null o un futuro que no haga nada
 // return Future.value(null);
}()
,
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
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardTareaWidget(
                      tareaModel: snapshot.data![index],
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

  Future<void> updateTaskList() async {
    List<TareaModel> tasks = [];

    if (_selectedEstado == 'Todas') {
      tasks = await schoolDB!.GETALLTASK3();
    } else {
      tasks = await schoolDB!.GET_TareaByEstado(_selectedEstado);
    }

    setState(() {
      // Actualizar la lista de tareas
      tasks = tasks;
    });
  }
}