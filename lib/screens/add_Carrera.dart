import 'package:flutter/material.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Carrera_model.dart';
import 'package:flutter_application_3/database/schooldb.dart';

class AddCarrera extends StatefulWidget {
  AddCarrera({super.key, this.carreraModel});

  CarreraModel? carreraModel;

  @override
  State<AddCarrera> createState() => _AddCarreraState();
}

class _AddCarreraState extends State<AddCarrera> {
  TextEditingController txtConnomCarrera = TextEditingController();

  SchoolDB? schoolDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schoolDB = SchoolDB();
    if (widget.carreraModel != null) {
      txtConnomCarrera.text = widget.carreraModel!.nomCarrera!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameCarrera = TextFormField(
      decoration: const InputDecoration(
          label: Text('Carrera'), border: OutlineInputBorder()),
      controller: txtConnomCarrera,
    );


    final space = SizedBox(
      height: 10,
    );



    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.carreraModel == null) {
            schoolDB!.INSERT_Carrera('tblCarrera', {
              'nomCarrera': txtConnomCarrera.text
            }).then((value) {
              GlobalValues.flagCarrera.value = !GlobalValues.flagCarrera.value;
              var msj = (value > 0)
                  ? 'La inserción fue exitosa!'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } else {
            schoolDB!.UPDATE_Carrera('tblCarrera', {
              'idCarrera': widget.carreraModel!.idCarrera,
                'nomCarrera': txtConnomCarrera.text
            }).then((value) {
               GlobalValues.flagCarrera.value = !GlobalValues.flagCarrera.value;
              var msj = (value > 0)
                  ? 'La actualización fue exitosa fue exitosa!'
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
        title:
            widget.carreraModel == null ? Text('Add Carrera') : Text('Update Carrera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameCarrera,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}
