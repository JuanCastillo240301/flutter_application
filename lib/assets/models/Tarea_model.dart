class TareaModel {
  int? idTarea;
  String? nomTarea;
  String? fecExpiracion;
  String? fecRecordatorio;
  String? desTarea;
  String? nomRealizada;
  int? idProfesor;

  TareaModel(
      {this.idTarea,
      this.nomTarea,
      this.fecExpiracion,
      this.fecRecordatorio,
      this.desTarea,
      this.nomRealizada,
      this.idProfesor});
  factory TareaModel.fromMap(Map<String, dynamic> map) {
    return TareaModel(
      idTarea: map['idTarea'],
      nomTarea: map['nomTarea'],
      fecExpiracion: map['fecExpiracion'],
      fecRecordatorio: map['fecRecordatorio'],
      desTarea: map['desTarea'],
      nomRealizada: map['nomRealizada'],
      idProfesor: map['idProfesor'],
    );
  }
}
