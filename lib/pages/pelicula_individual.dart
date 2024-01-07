// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sked/models/modelo_pelicula.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PeliculaIndividual extends StatefulWidget {
  final ModeloPelicula? modeloPelicula;
  final Function(int) onBodyChanged;

  const PeliculaIndividual({
    this.modeloPelicula,
    super.key,
    required this.onBodyChanged,
  });

  @override
  State<PeliculaIndividual> createState() => _PeliculaIndividualState();
}

class _PeliculaIndividualState extends State<PeliculaIndividual> {
  @override
  Widget build(BuildContext context) {
    String formatTime(int totalMinutes) {
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;

      if (hours > 0 && minutes > 0) {
        return '$hours\h $minutes\m';
      } else if (hours > 0) {
        return '$hours h';
      } else if (minutes > 0) {
        return '$minutes m';
      } else {
        return '0 m';
      }
    }

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
          widget.modeloPelicula!.verticalPosterURL,
        ),
        Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(172, 26, 26, 1),
                    Color.fromRGBO(177, 69, 69, 0.486),
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
                      top: MediaQuery.sizeOf(context).height * .28),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            widget.modeloPelicula!.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/imdbLogo.png',
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RatingBarIndicator(
                              rating: (double.parse(
                                      widget.modeloPelicula!.imdbRating) /
                                  2),
                              itemBuilder: (context, index) {
                                return const Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                  size: 35,
                                );
                              },
                              itemCount: 5,
                              itemSize: 30,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Text(
                                widget.modeloPelicula!.imdbRating,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.modeloPelicula!.genres.join("  \u2022  "),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(78, 124, 193, 0.7),
                                    border: Border.all(
                                        width: 2,
                                        color: const Color.fromRGBO(
                                            0, 79, 197, 1)),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 3, 5, 1),
                                    child: Text(
                                      widget.modeloPelicula!.ageRating,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.slow_motion_video,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                                child: Text(
                                    formatTime(widget.modeloPelicula!.runtime),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
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
                                      widget.modeloPelicula!.releaseDate),
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
                          widget.modeloPelicula!.overview,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
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
                              widget.modeloPelicula!.direction,
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
                              width: 34.8,
                            ),
                            Expanded(
                              child: Text(
                                widget.modeloPelicula!.cast.join(", "),
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
