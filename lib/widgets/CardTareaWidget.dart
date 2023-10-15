import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Profesor_model.dart';
import 'package:flutter_application_3/assets/models/Tarea_model.dart';
import 'package:flutter_application_3/database/schooldb.dart';
import 'package:flutter_application_3/screens/add_Profesor.dart';
import 'package:flutter_application_3/screens/add_Tarea.dart';

class CardTareaWidget extends StatelessWidget {
  CardTareaWidget({super.key, required this.tareaModel, this.schoolDB});

  TareaModel tareaModel;
  SchoolDB? schoolDB;
  String isaas = 'id Profesor: ';
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
              Text(tareaModel.nomTarea ?? 'Nombre no disponible'),
              Text(tareaModel.desTarea ?? 'Email no disponible'),
              Text(tareaModel.fecExpiracion ?? 'Email no disponible'),
              Text(tareaModel.fecRecordatorio ?? 'Email no disponible'),
              Text(tareaModel.nomRealizada ?? 'Email no disponible'),

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
                              AddTarea(tareaModel: tareaModel))),
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
                                      .DELETE_Tarea(
                                          'tblTarea', tareaModel.idTarea!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagTarea.value =
                                        !GlobalValues.flagTarea.value;
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
