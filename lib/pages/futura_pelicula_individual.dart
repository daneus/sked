import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sked/models/modelo_futura_pelicula.dart';

class FuturaPeliculaIndividual extends StatefulWidget {
  final ModeloFuturaPelicula? modeloFuturaPelicula;

  const FuturaPeliculaIndividual(
      {required this.modeloFuturaPelicula, super.key});

  @override
  State<FuturaPeliculaIndividual> createState() =>
      _FuturaPeliculaIndividualState();
}

class _FuturaPeliculaIndividualState extends State<FuturaPeliculaIndividual> {
  @override
  Widget build(BuildContext context) {
    String formatDate(String dateString) {
      initializeDateFormatting('es');
      DateTime date = DateTime.parse(dateString);
      String formattedDate =
          DateFormat('d \'de\' MMMM \'de\' y', 'es').format(date);
      return formattedDate;
    }

    return Scaffold(
        body: Stack(
      children: [
        Image.network(
          widget.modeloFuturaPelicula!.verticalPosterURL,
        ),
        Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(75, 4, 141, 1),
                    Color.fromRGBO(42, 9, 73, 0.493),
                    Colors.transparent
                  ],
                  stops: <double>[
                    .55,
                    .85,
                    1
                  ]),
            ),
          ),
          SafeArea(
              child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * .375),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            widget.modeloFuturaPelicula!.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        Text(
                            widget.modeloFuturaPelicula!.genres
                                .join("  \u2022  "),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                  formatDate(
                                      widget.modeloFuturaPelicula!.releaseDate),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.modeloFuturaPelicula!.overview,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15.5),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Dirección:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              widget.modeloFuturaPelicula!.direction,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Reparto:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 34,
                            ),
                            Expanded(
                              child: Text(
                                widget.modeloFuturaPelicula!.cast.join(", "),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 17),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )))
        ])
      ],
    ));
  }
}
