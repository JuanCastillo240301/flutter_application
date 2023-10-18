import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Carrera_model.dart';
import 'package:flutter_application_3/assets/models/Profesor_model.dart';
import 'package:flutter_application_3/database/schooldb.dart';

class AddProfesor extends StatefulWidget {
  AddProfesor({super.key, this.profesoreModel});

  ProfesorModel? profesoreModel;

  @override
  State<AddProfesor> createState() => _AddProfesorState();
}

class _AddProfesorState extends State<AddProfesor> {
  int? selectedCarreraId;
  List<int> carreraIds = [];
  String? selectedCarreraname;
  List<String> carreraname = [];
  TextEditingController txtConnomProfesor = TextEditingController();
  TextEditingController txtConemail = TextEditingController();
  int? dropDownValue;
  List<String> dropDownValues = [];

  SchoolDB? schoolDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schoolDB = SchoolDB();
    if (widget.profesoreModel != null) {
      txtConnomProfesor.text = widget.profesoreModel!.nomProfesor!;
      txtConemail.text = widget.profesoreModel!.email!;
       selectedCarreraId = widget.profesoreModel!.idCarrera!;
      schoolDB!.getCarreraIdsFromDatabase().then((ids) {
        setState(() {
          carreraIds = ids;
        });
      });

      schoolDB!.getCarreraNameFromDatabase().then((name) {
        setState(() {
          carreraname = name;
        });
      });
    }
    schoolDB!.getCarreraIdsFromDatabase().then((ids) {
      setState(() {
        carreraIds = ids;
      });
    });
    schoolDB!.getCarreraNameFromDatabase().then((name) {
      setState(() {
        carreraname = name;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final txtNameProfesor = TextFormField(
      decoration: const InputDecoration(
          label: Text('Profesor'), border: OutlineInputBorder()),
      controller: txtConnomProfesor,
    );
    final txtEmail = TextFormField(
      decoration: const InputDecoration(
          label: Text('Email'), border: OutlineInputBorder()),
      controller: txtConemail,
    );
    final space = SizedBox(
      height: 10,
    );
    final dropdownCarrera = DropdownButton<int>(
      value: selectedCarreraId,
      items: carreraIds.map((id) {
        return DropdownMenuItem<int>(
          value: id,
          child: Text('${carreraname[id - 1]} id: $id'),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCarreraId = value;
        });
      },
    );

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.profesoreModel == null) {
            schoolDB!.INSERT_Profesor('tblProfesor', {
              'nomProfesor': txtConnomProfesor.text,
              'email': txtConemail.text,
              'idCarrera': selectedCarreraId!
            }).then((value) {
              GlobalValues.flagProfesor.value =
                  !GlobalValues.flagProfesor.value;
              var msj = (value > 0)
                  ? 'La inserción fue exitosa!'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } else {
            schoolDB!.UPDATE_Profesor('tblProfesor', {
              'idProfesor': widget.profesoreModel!.idProfesor,
              'nomProfesor': txtConnomProfesor.text,
              'email': txtConemail.text,
              'idCarrera': selectedCarreraId!
            }).then((value) {
              GlobalValues.flagProfesor.value =
                  !GlobalValues.flagProfesor.value;
              var msj = (value > 0)
                  ? 'La actualización fue exitosa!'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        },
        child: Text('Save Task'));

    return Scaffold(
      appBar: AppBar(
        title: widget.profesoreModel == null
            ? Text('Add Profesor')
            : Text('Update Profesor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameProfesor,
            space,
            txtEmail,
            space,
            dropdownCarrera,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}
