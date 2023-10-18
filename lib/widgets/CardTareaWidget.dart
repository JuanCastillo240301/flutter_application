import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Profesor_model.dart';
import 'package:flutter_application_3/assets/models/Tarea_model.dart';
import 'package:flutter_application_3/database/schooldb.dart';
import 'package:flutter_application_3/screens/add_Profesor.dart';
import 'package:flutter_application_3/screens/add_Tarea.dart';

import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  
  const CustomCheckbox({this.value, this.onChanged});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onChanged != null) {
          widget.onChanged!(!widget.value!);
        }
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: widget.value!
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              )
            : null,
      ),
    );
  }
}

class CardTareaWidget extends StatelessWidget {
  CardTareaWidget({super.key, required this.tareaModel, this.schoolDB});

  TareaModel tareaModel;
  SchoolDB? schoolDB;
  //String isaas = 'id Profesor: ';
  int? selectedProfesorId;
 
  @override
  Widget  build(BuildContext context ) {
    selectedProfesorId =tareaModel.idProfesor;
    return Container (
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
              Text(tareaModel.nomRealizada ?? 'Estado no disponible'),
              //Text(a as String),
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
                  'assets/IconHomeworks.png',
                  height: 50,
                ),
              ),
              CustomCheckbox(
                value: tareaModel.nomRealizada == 'Completado',
                onChanged: (bool? value) {
                  if (value != null) {
                    String nuevoEstado = value ? 'Completado' : 'Pendiente';
                    schoolDB!
                        .updateTareaCompletion(tareaModel.idTarea!, value)
                        .then((value) {
                      if (value > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Tarea marcada como $nuevoEstado.'),
                        ));
                        GlobalValues.flagTarea.value =
                            !GlobalValues.flagTarea.value;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Error al actualizar el estado de la tarea.'),
                        ));
                      }
                    });
                  }
                },
              ),
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
                                      .DELETE_Tarea('tblTarea',
                                          tareaModel.idTarea!)
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
