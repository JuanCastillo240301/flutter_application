class ProfesorModel {
  int? idProfesor;
  String? nomProfesor;
  int? idCarrera;
  String? email;

  ProfesorModel(
      {this.idProfesor, this.nomProfesor, this.idCarrera, this.email});
  factory ProfesorModel.fromMap(Map<String, dynamic> map) {
    return ProfesorModel(
      idProfesor: map['idProfesor'],
      nomProfesor: map['nomProfesor'],
      idCarrera: map['idCarrera'],
      email: map['email'],
    );
  }
}
