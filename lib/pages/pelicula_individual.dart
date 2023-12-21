import 'package:flutter/material.dart';
import 'package:sked/models/modelo_pelicula.dart';
import 'package:palette_generator/palette_generator.dart';

class PeliculaIndividual extends StatefulWidget {
  final ModeloPelicula? modeloPelicula;

  const PeliculaIndividual({required this.modeloPelicula, super.key});

  @override
  State<PeliculaIndividual> createState() => _PeliculaIndividualState();
}

class _PeliculaIndividualState extends State<PeliculaIndividual> {
  late Future<PaletteGenerator> _paletteGenerator;

  @override
  void initState() {
    super.initState();
    _paletteGenerator = _generatePalette();
  }

  Future<PaletteGenerator> _generatePalette() async {
    return PaletteGenerator.fromImageProvider(
        NetworkImage(widget.modeloPelicula!.verticalPosterURL));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PaletteGenerator>(
        future: _paletteGenerator,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a circular spinner while waiting for the result
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle error
            return const Center(
              child: Text('Error fetching dominant color'),
            );
          } else {
            Color backgroundColor =
                snapshot.data?.dominantColor?.color ?? Colors.white;
            double luminance = backgroundColor.computeLuminance();
            return Stack(
              children: [
                Image.network(
                  widget.modeloPelicula!.verticalPosterURL,
                ),
                Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [backgroundColor, Colors.transparent],
                          stops: const <double>[.65, 1]),
                    ),
                  ),
                  SafeArea(
                      child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).height * .325),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Text(
                                  widget.modeloPelicula!.title,
                                  style: TextStyle(
                                      color: luminance > 0.5
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/imdbLogo.png',
                                      height: 25,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )))
                ])
              ],
            );
          }
        },
      ),
    );
  }
}
