import 'package:flutter/material.dart';
import 'package:flutter_application_3/database/agendadb.dart';

import '../assets/models/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

Agendadb? agendaDB;

@override
void initState() {
  super.initState();
 agendaDB = Agendadb(); 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title:Text('hola'),
  actions: [
    IconButton(
      onPressed: ()=>{ Navigator.pushNamed(context, '/add')}, 
    icon: Icon(Icons.task)
    )
  ],
),
body: FutureBuilder(future: agendaDB!.GETALLTASK()
, builder: (
  BuildContext context,
  AsyncSnapshot<List<TaskModel>> snapshot){
    if(snapshot.hasData){
      return ListView.builder(
        itemCount: 5,//snapshot.data!.length,
        itemBuilder: (BuildContext context, int index){
          return const Text('hola');
        }
    
      );
    }else{
      if (snapshot.hasError) {
        return const Center(
          child: Text('que menso'),
        );
      }else{
        return CircularProgressIndicator();
      }
    }
  }),
    );

  }
}