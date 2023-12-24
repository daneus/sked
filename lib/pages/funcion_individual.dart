import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sked/models/mode_funcion.dart';

class FuncionIndividual extends StatefulWidget {
  final ModeloFuncion? modeloFuncion;
  const FuncionIndividual({super.key, this.modeloFuncion});

  @override
  State<FuncionIndividual> createState() => _FuncionIndividualState();
}

class _FuncionIndividualState extends State<FuncionIndividual> {
  ImageStream? _imageStream;
  bool _isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    _imageStream = Image.network(
      widget.modeloFuncion!.backdropURL,
    ).image.resolve(ImageConfiguration.empty);

    _imageStream!.addListener(
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
      setState(() {
        _isImageLoaded = true;
      });
    }));
  }

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
        body: _isImageLoaded
            ? Stack(children: [
                Container(
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
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.transparent, Colors.black])
                          .createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.network(widget.modeloFuncion!.backdropURL,
                        fit: BoxFit.cover, loadingBuilder:
                            (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        _isImageLoaded = true;
                      }
                      return child;
                    }),
                  ),
                ),
                Positioned(
                  top: 250,
                  right: 0,
                  left: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 6,
                              width: 150,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Colors.yellow),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Detalles de función",
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 6,
                              width: 150,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  color: Colors.yellow),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.modeloFuncion!.title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.date_range,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Row(
                                      children: [
                                        Text(
                                          formatDate(widget
                                              .modeloFuncion!.functionDate),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          '\u2022',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.modeloFuncion!.functionTime,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  widget.modeloFuncion!.format == "IMAX"
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Colors.white,
                                          ),
                                          width: 65,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Image.asset(
                                              'assets/imaxLogo.png',
                                              width: 30,
                                            ),
                                          ))
                                      : Container(
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
                                                widget.modeloFuncion!.format,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "\u2022",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          formatTime(
                                              widget.modeloFuncion!.runtime),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 6.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(widget.modeloFuncion!.cinema,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.event_seat_rounded,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 6.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                        widget.modeloFuncion!.seats.join(", "),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.videocam,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 6.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(widget.modeloFuncion!.screen,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ]),
                )
              ])
            : Container(
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
                child: const Center(
                    child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 6,
                  ),
                )),
              ));
  }
}
