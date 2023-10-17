import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Carrera_model.dart';
import 'package:flutter_application_3/assets/models/Profesor_model.dart';
import 'package:flutter_application_3/assets/models/Tarea_model.dart';
import 'package:flutter_application_3/assets/models/Tarea_model.dart';
import 'package:flutter_application_3/assets/models/Tarea_model.dart';
import 'package:flutter_application_3/database/Noti.dart';
import 'package:flutter_application_3/database/schooldb.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class AddTarea extends StatefulWidget {
  AddTarea({super.key, this.tareaModel});


  TareaModel? tareaModel;
  @override
  State<AddTarea> createState() => _AddTareaState();
}

class _AddTareaState extends State<AddTarea> {
  
  DateTime? selectedDate1;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<TareaModel> _tasks = [];
  String _selectedEstado = 'Todas';
  int? selectedProfesorId;
  List<int> profesorIds = [];
  String? selectedprofesorname;
  List<String> profesorname = [];
  String? dropDownValue = "Pendiente";
  TextEditingController txtConnameTarea = TextEditingController();
  DateTime? fecExpiracion;
  DateTime? fecRecordatorio;
  TextEditingController txtFechaExpiracion = TextEditingController();
  TextEditingController txtFechaRecordatorio = TextEditingController();
  TextEditingController desTarea = TextEditingController();
  List<String> dropDownValues = ['Pendiente', 'Completado'];

  SchoolDB? schoolDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    schoolDB = SchoolDB();
    if (widget.tareaModel != null) {
      txtConnameTarea.text = widget.tareaModel!.nomTarea!;
      desTarea.text = widget.tareaModel!.desTarea!;
      txtFechaExpiracion.text = widget.tareaModel!.fecExpiracion!;
      txtFechaRecordatorio.text =widget.tareaModel!.fecRecordatorio!;
      selectedProfesorId =  widget.tareaModel!.idProfesor!;
      switch (widget.tareaModel!.nomRealizada) {
        case 'Pendiente':
          dropDownValue = "Pendiente";
          break;
        case 'Completado':
          dropDownValue = "Completado";
      }

      schoolDB!.getProfesorIdsFromDatabase().then((ids) {
        setState(() {
          profesorIds = ids;
        });
      });

      schoolDB!.getProfesorNameFromDatabase().then((name) {
        setState(() {
          profesorname = name;
        });
      });
    }
    schoolDB!.getProfesorIdsFromDatabase().then((ids) {
      setState(() {
        profesorIds = ids;
      });
    });

    schoolDB!.getProfesorNameFromDatabase().then((name) {
      setState(() {
        profesorname = name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtFecha1 = TextFormField(
      decoration: const InputDecoration(
          label: Text('Fecha de Expiración'), border: OutlineInputBorder()),
      controller: txtFechaExpiracion,
      onTap: () => _selectFechaExpiracion(context),
    );
    final txtFecha2 = TextFormField(
      decoration: const InputDecoration(
          label: Text('Fecha de Recordatorio'), border: OutlineInputBorder()),
      controller: txtFechaRecordatorio,
      onTap: () => _selectFechaRecordatorio(context),
    );
    final txtNameTarea = TextFormField(
      decoration: const InputDecoration(
          label: Text('Tarea'), border: OutlineInputBorder()),
      controller: txtConnameTarea,
    );
    final txtdesTarea = TextFormField(
      decoration: const InputDecoration(
          label: Text('Descripcion'), border: OutlineInputBorder()),
      controller: desTarea,
    );
    final space = SizedBox(
      height: 10,
    );

    final DropdownButton ddBStatus = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            .map((status) =>
                DropdownMenuItem(value: status, child: Text(status)))
            .toList(),
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });

    final dropdownCarrera = DropdownButton<int>(
      value: selectedProfesorId,
      items: profesorIds.map((id) {
        return DropdownMenuItem<int>(
          value: id,
          child: Text('${profesorname[id - 1]} id: $id'),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedProfesorId = value;
        });
      },
    );

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          scheduleNotification('123','123');
                showNotification(txtConnameTarea.text, 'Tarea Programada');
          if (widget.tareaModel == null) {
           
            schoolDB!.INSERT_Tarea('tblTarea', {
              'nomTarea': txtConnameTarea.text,
              'fecExpiracion': txtFechaExpiracion.text,
              'fecRecordatorio': txtFechaRecordatorio.text,
              'desTarea': desTarea.text,
              'nomRealizada': dropDownValue!,
              'idProfesor': selectedProfesorId!
            }).then((value) {
              GlobalValues.flagTarea.value = !GlobalValues.flagTarea.value;
              var msj = (value > 0)
                  ? 'Tarea creada'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } else {
            schoolDB!.UPDATE_Tarea('tblTarea', {
              'idTarea': widget.tareaModel!.idTarea,
              'nomTarea': txtConnameTarea.text,
              'fecExpiracion': txtFechaExpiracion.text,
              'fecRecordatorio': txtFechaRecordatorio.text,
              'desTarea': desTarea.text,
              'nomRealizada': dropDownValue!,
              'idProfesor': selectedProfesorId!
            }).then((value) {
              GlobalValues.flagTarea.value = !GlobalValues.flagTarea.value;
              var msj = (value > 0)
                  ? 'Tarea Actualizada'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
             
              Navigator.pop(context);
            });
          }
        },
        child: Text('Save Tarea'));

    return Scaffold(
      appBar: AppBar(
        title: widget.tareaModel == null
            ? Text('Add Tarea')
            : Text('Update Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameTarea,
            space,
            txtdesTarea,
            space,
            txtFecha1,
            space,
            txtFecha2,
            space,
            dropdownCarrera,
            space,
            ddBStatus,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }

  Future<void> _selectFechaExpiracion(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        String a = selectedDate.toString();
        var date = DateTime.parse(a);
        var formattedDate = "${date.day}-${date.month}-${date.year}";
        txtFechaExpiracion.text = formattedDate.toString();
      });
    }
  }

Future<void> _selectFechaRecordatorio(BuildContext context) async {
   selectedDate1 = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (selectedDate1 != null) {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (selectedTime != null) {
      DateTime selectedDateTime = DateTime(
        selectedDate1!.year,
        selectedDate1!.month,
        selectedDate1!.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      setState(() {
        String formattedDate =
            "${selectedDateTime.day}-${selectedDateTime.month}-${selectedDateTime.year} ${selectedTime.format(context)}";
        txtFechaRecordatorio.text = formattedDate;
      });
    }
  }
}


}
