import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/task_model.dart';
import 'package:flutter_application_3/database/agendadb.dart';

// ignore: must_be_immutable
class CardTaskWidget extends StatelessWidget {
  CardTaskWidget(
    {super.key,required this.taskModel, this.agendaDB}
  );

  TaskModel taskModel;
  AgendaDB? agendaDB;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 224, 0, 0)
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(taskModel.nameTask ?? 'Default Name'),
Text(taskModel.dscTask ?? 'Default Description'),
Text(taskModel.sttTask ?? 'Default state')
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: (){},
              child: Image.asset('assets/icon1.png', height: 50,),
             
              ),
               IconButton(onPressed: (){
                showDialog(
                  context: context
                , builder: (context){
                  return  AlertDialog(
                    title: Text('Mensaje del sistema'),
                    content: Text('¿Deseas borrar la tarea?'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          agendaDB!.DELETE('tblTareas',taskModel.idTask!).then((value) => {
                            Navigator.pop(context),
                            GlobalValues.flagTask.value = !GlobalValues.flagTask.value
                          });
                        }, 
                        child: Text('SI')
                        ),
                      TextButton(
                        onPressed: ()=>Navigator.pop(context), 
                        child: Text('NO')
                        )
                    ],
                  );
                }
                );
               }, icon: Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }
}