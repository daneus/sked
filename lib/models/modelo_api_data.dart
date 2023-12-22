import 'package:sked/models/modelo_futura_pelicula.dart';
import 'package:sked/models/modelo_pelicula.dart';

class ModeloAPIData {
  List<ModeloPelicula>? cartelera;
  List<ModeloFuturaPelicula>? proximamente;

  ModeloAPIData({this.cartelera, this.proximamente});
}
