import 'package:flutter/material.dart';
import 'package:sked/models/modelo_pelicula.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PeliculaIndividual extends StatefulWidget {
  final ModeloPelicula? modeloPelicula;

  const PeliculaIndividual({required this.modeloPelicula, super.key});

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
                      top: MediaQuery.sizeOf(context).height * .325),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            widget.modeloPelicula!.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 26),
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
                                  size: 30,
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
                                    fontSize: 18,
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
                                fontSize: 16)),
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
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.calendar_month,
                        //       color: Colors.white,
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 6),
                        //       child: Text(widget.modeloPelicula!.releaseDate),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  )))
        ])
      ],
    ));
  }
}
