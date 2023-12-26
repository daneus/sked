import 'package:sked/models/modelo_funcion.dart';
import 'package:sked/models/modelo_futura_pelicula.dart';
import 'package:sked/models/modelo_pelicula.dart';

class ModeloAPIData {
  List<ModeloPelicula>? cartelera;
  List<ModeloFuturaPelicula>? proximamente;
  List<ModeloFuncion>? funciones;
  List<dynamic>? fotosVisitas;

  ModeloAPIData(
      {this.cartelera, this.proximamente, this.funciones, this.fotosVisitas});
}
