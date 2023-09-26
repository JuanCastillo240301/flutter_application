import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/database/agendadb.dart';
import 'package:flutter_application_3/widgets/CardTaskWidget.dart';

import '../assets/models/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager',style: Theme.of(context).textTheme.headline6,),
        actions: [
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/add',)
              .then((value){
                setState(() {});
              }
            ), 
            icon: Icon(Icons.task, color: Colors.black)
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagTask,
        builder: (context,value,_) {
          return FutureBuilder(
            future: agendaDB!.GETALLTASK(),
            builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot){
              if( snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return CardTaskWidget(taskModel: snapshot.data![index],agendaDB:agendaDB);
                  }
                );
              }else{
                if( snapshot.hasError ){
                  return const Center(
                    child: Text('Error!'),
                  );
                }else{
                  return CircularProgressIndicator();
                }
              }
            }
          );
        }
      ),
    );
  }
}