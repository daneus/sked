class ModeloPelicula {
  //From primary API
  final String verticalPosterURL;
  final String titulo;
  final int runtime;
  //From secondary API
  final String imdbRating;
  final String ageRating;

  ModeloPelicula(
      {required this.verticalPosterURL,
      required this.titulo,
      required this.runtime,
      required this.imdbRating,
      required this.ageRating});

  factory ModeloPelicula.fromJson(Map<String, dynamic> json) {
    return ModeloPelicula(
        verticalPosterURL: json['verticalPosterURL'],
        titulo: json['titulo'],
        runtime: json['runtime'],
        imdbRating: json['imdbRating'],
        ageRating: json['ageRating']);
  }
}
