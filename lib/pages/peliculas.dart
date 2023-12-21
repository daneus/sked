// ignore_for_file: unnecessary_string_escapes
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sked/main.dart';
import '../models/modelo_pelicula.dart';

class Peliculas extends StatefulWidget {
  final Function(int) onBodyChanged;
  final Function(ModeloPelicula) onPeliculaSelected;

  const Peliculas(
      {required this.onBodyChanged,
      required this.onPeliculaSelected,
      super.key});

  @override
  State<Peliculas> createState() => _PeliculasState();
}

class _PeliculasState extends State<Peliculas> {
  List<String> tabs = ["En cartelera", "Próximamente"];
  int currentTab = 0;
  List<double> changePositionAndWidthOfLine() {
    switch (currentTab) {
      case 0:
        return [43, 115];
      case 1:
        return [223, 143];
      default:
        return [0, 100];
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataModel = Provider.of<DataModel>(context);

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

    return Material(
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                Color(0xFFFF9900),
                Color(0xFFBF001D),
                Color(0xFFA50F3D),
                Color(0xFF143A6B),
                Color(0xFF1F5286),
                Color(0xFF008DFF)
              ],
                  stops: <double>[
                0,
                0.2,
                0.33,
                0.7,
                0.82,
                1
              ])),
          child: SafeArea(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "Películas",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 40),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentTab = 0;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "En cartelera",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: currentTab == 0
                                      ? Colors.white
                                      : const Color.fromRGBO(160, 160, 160, 1)),
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentTab = 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Próximamente",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: currentTab == 1
                                      ? Colors.white
                                      : const Color.fromRGBO(160, 160, 160, 1)),
                            )),
                          ),
                        )
                      ],
                    ),
                    AnimatedPositioned(
                      bottom: 0,
                      curve: Curves.fastLinearToSlowEaseIn,
                      left: changePositionAndWidthOfLine()[0],
                      duration: const Duration(milliseconds: 600),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: changePositionAndWidthOfLine()[1],
                        height: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: MediaQuery.of(context).size.width,
                child: IndexedStack(
                  index: currentTab,
                  children: [
                    FutureBuilder(
                      future: dataModel.fetchMovies(),
                      builder: (context, snapshot) {
                        final List<ModeloPelicula> movies = snapshot.data ?? [];
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return Container(
                                width: 280,
                                margin:
                                    const EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        widget.onPeliculaSelected(movie);
                                        widget.onBodyChanged(3);
                                      },
                                      child: Container(
                                        decoration:
                                            const BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            offset: Offset(4, 4),
                                            blurRadius: 6.5,
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                          )
                                        ]),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            movie.verticalPosterURL,
                                            width: 270,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, bottom: 3),
                                      child: Text(
                                        movie.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Center(
                                            child: Image.asset(
                                              'assets/imdbLogo.png',
                                              height: 25,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Icon(
                                          Icons.star_rate_rounded,
                                          size: 28,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          height: 25,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: Text(
                                                movie.imdbRating,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    height: 1,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  78, 124, 193, 0.7),
                                              border: Border.all(
                                                  width: 2,
                                                  color: const Color.fromRGBO(
                                                      0, 79, 197, 1)),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 3, 5, 1),
                                              child: Text(
                                                movie.ageRating,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(
                                          Icons.slow_motion_video,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              4, 4, 0, 0),
                                          child: Text(formatTime(movie.runtime),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      ],
                                    )
                                  ],
                                ));
                          },
                        );
                        // }
                      },
                    ),
                    FutureBuilder(
                      future: dataModel.fetchMovies(),
                      builder: (context, snapshot) {
                        final List<ModeloPelicula> movies = snapshot.data ?? [];
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return Container(
                                width: 280,
                                margin:
                                    const EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        widget.onPeliculaSelected(movie);
                                        widget.onBodyChanged(3);
                                      },
                                      child: Container(
                                        decoration:
                                            const BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            offset: Offset(4, 4),
                                            blurRadius: 6.5,
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                          )
                                        ]),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            movie.verticalPosterURL,
                                            width: 270,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, bottom: 3),
                                      child: Text(
                                        movie.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Center(
                                            child: Image.asset(
                                              'assets/imdbLogo.png',
                                              height: 25,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Icon(
                                          Icons.star_rate_rounded,
                                          size: 28,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          height: 25,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: Text(
                                                movie.imdbRating,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    height: 1,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  78, 124, 193, 0.7),
                                              border: Border.all(
                                                  width: 2,
                                                  color: const Color.fromRGBO(
                                                      0, 79, 197, 1)),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 3, 5, 1),
                                              child: Text(
                                                movie.ageRating,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(
                                          Icons.slow_motion_video,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              4, 4, 0, 0),
                                          child: Text(formatTime(movie.runtime),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      ],
                                    )
                                  ],
                                ));
                          },
                        );
                        // }
                      },
                    )
                  ],
                ),
              ))
            ],
          )),
        ),
      ),
    );
  }
}
