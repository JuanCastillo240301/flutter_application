import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Carrera_model.dart';
import 'package:flutter_application_3/database/schooldb.dart';
import 'package:flutter_application_3/screens/add_Carrera.dart';


class CardCarreraWidget extends StatelessWidget {
  CardCarreraWidget({super.key, required this.carreraModel, this.schoolDB});

  CarreraModel carreraModel;
  SchoolDB? schoolDB;

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
              Text(carreraModel.nomCarrera!),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCarrera(carreraModel: carreraModel))),
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
                                      .DELETE_Carrera('tblCarrera', carreraModel.idCarrera!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagCarrera.value =
                                        !GlobalValues.flagCarrera.value;
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
