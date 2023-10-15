import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Profesor_model.dart';
import 'package:flutter_application_3/database/schooldb.dart';
import 'package:flutter_application_3/screens/add_Profesor.dart';

class CardProfesorWidget extends StatelessWidget {
  CardProfesorWidget({super.key, required this.profesorModel, this.schoolDB});

  ProfesorModel profesorModel;
  SchoolDB? schoolDB;
  String isaas = 'id Carrera: ';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color(0xFFE53935)),
      child: Row(
        children: [
          Column(
            children: [
              Text(profesorModel.nomProfesor ?? 'Nombre no disponible'),
              Text(profesorModel.email ?? 'Email no disponible'),
              //Text(profesorModel.idCarrera!),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddProfesor(profesoreModel: profesorModel))),
                  child: Image.asset(
                    'assets/IconCarrera.png',
                    height: 50,
                  )),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: Text('¿Deseas borrar la tarea?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  schoolDB!
                                      .DELETE_Profesor('tblProfesor',
                                          profesorModel.idProfesor!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagProfesor.value =
                                        !GlobalValues.flagProfesor.value;
                                  });
                                },
                                child: Text('Si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No')),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
