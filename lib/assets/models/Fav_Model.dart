class FavModel {
  int? idApi;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;

  FavModel(
      {this.idApi,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.voteAverage});
  factory FavModel.fromMap(Map<String, dynamic> map) {
    return FavModel(
        idApi: map['idApi'],
        originalTitle: map['originalTitle'],
        overview: map['overview'],
        posterPath: map['posterPath'],
        releaseDate: map['releaseDate'],
        title: map['title'],
        voteAverage: map['voteAverage']);
  }
}
