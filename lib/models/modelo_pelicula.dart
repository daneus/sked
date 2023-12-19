class ModeloPelicula {
  //From primary API
  final String verticalPosterURL;
  final String title;
  final int runtime;
  final List<dynamic> cast;
  final String direction;
  final List<dynamic> genres;
  final String overview;
  final String releaseDate;
  //From secondary API
  final String imdbRating;
  final String ageRating;

  ModeloPelicula(
      {required this.verticalPosterURL,
      required this.title,
      required this.runtime,
      required this.cast,
      required this.direction,
      required this.genres,
      required this.overview,
      required this.releaseDate,
      required this.imdbRating,
      required this.ageRating});

  factory ModeloPelicula.fromJson(Map<String, dynamic> json) {
    return ModeloPelicula(
        verticalPosterURL: json['verticalPosterURL'],
        title: json['title'],
        runtime: json['runtime'],
        cast: json['cast'],
        direction: json['direction'],
        genres: json['genres'],
        overview: json['overview'],
        releaseDate: json['releaseDate'],
        imdbRating: json['imdbRating'],
        ageRating: json['ageRating']);
  }
}
