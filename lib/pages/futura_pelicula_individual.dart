import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sked/models/modelo_futura_pelicula.dart';

class FuturaPeliculaIndividual extends StatefulWidget {
  final ModeloFuturaPelicula? modeloFuturaPelicula;
  final Function(int) onBodyChanged;

  const FuturaPeliculaIndividual(
      {required this.modeloFuturaPelicula,
      super.key,
      required this.onBodyChanged});

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
                    padding: const EdgeInsets.only(left: 30, right: 30),
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
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Text(
                            widget.modeloFuturaPelicula!.genres
                                .join("  \u2022  "),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20)),
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
                                      fontSize: 18)),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.modeloFuturaPelicula!.overview,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17.5),
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
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              widget.modeloFuturaPelicula!.direction,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Expanded(
                              child: Text(
                                widget.modeloFuturaPelicula!.cast.join(", "),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: GestureDetector(
              onTap: () {
                widget.onBodyChanged(0);
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 44, 44, 44)),
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    size: 50,
                    color: Colors.white,
                  )),
            ),
          ))
        ])
      ],
    ));
  }
}
