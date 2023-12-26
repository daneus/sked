class ModeloFuncion {
  final String backdropURL;
  final String title;
  final int runtime;
  final String format;
  final String functionDate;
  final String functionTime;
  final String cinema;
  final List<dynamic> seats;
  final String screen;
  final List<dynamic> genres;

  ModeloFuncion(
      {required this.backdropURL,
      required this.title,
      required this.runtime,
      required this.format,
      required this.functionDate,
      required this.functionTime,
      required this.cinema,
      required this.seats,
      required this.screen,
      required this.genres});

  factory ModeloFuncion.fromJson(Map<String, dynamic> json) {
    return ModeloFuncion(
        backdropURL: json['backdropURL'],
        title: json['title'],
        runtime: json['runtime'],
        format: json['format'],
        functionDate: json['functionDate'],
        functionTime: json['functionTime'],
        cinema: json['cinema'],
        seats: json['seats'],
        screen: json['screen'],
        genres: json['genres']);
  }
}
