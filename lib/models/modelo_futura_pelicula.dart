class ModeloFuturaPelicula {
  final String verticalPosterURL;
  final String title;
  final List<dynamic> cast;
  final String direction;
  final List<dynamic> genres;
  final String overview;
  final String releaseDate;

  ModeloFuturaPelicula({
    required this.verticalPosterURL,
    required this.title,
    required this.cast,
    required this.direction,
    required this.genres,
    required this.overview,
    required this.releaseDate,
  });

  factory ModeloFuturaPelicula.fromJson(Map<String, dynamic> json) {
    return ModeloFuturaPelicula(
      verticalPosterURL: json['verticalPosterURL'],
      title: json['title'],
      cast: json['cast'],
      direction: json['direction'],
      genres: json['genres'],
      overview: json['overview'],
      releaseDate: json['releaseDate'],
    );
  }
}
