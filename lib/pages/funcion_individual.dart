// ignore_for_file: unnecessary_string_escapes

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sked/models/modelo_funcion.dart';
import 'package:http/http.dart' as http;

class StarIcon extends StatelessWidget {
  final bool filled;

  const StarIcon({super.key, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Icon(
      filled ? Icons.star_rounded : Icons.star_border_rounded,
      color: const Color.fromRGBO(0, 123, 222, 1),
      size: 35,
    );
  }
}

class FuncionIndividual extends StatefulWidget {
  final ModeloFuncion? modeloFuncion;
  const FuncionIndividual({super.key, this.modeloFuncion});

  @override
  State<FuncionIndividual> createState() => _FuncionIndividualState();
}

class _FuncionIndividualState extends State<FuncionIndividual> {
  ImageStream? _imageStream;
  bool _isBackdropLoaded = false;
  File? imageFile;
  double _rating = 0;
  bool isPictureSending = false;

  @override
  void initState() {
    super.initState();
    _imageStream = Image.network(
      widget.modeloFuncion!.backdropURL,
    ).image.resolve(ImageConfiguration.empty);

    _imageStream!.addListener(
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
      setState(() {
        _isBackdropLoaded = true;
      });
    }));
  }

  void _chooseImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    });
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

    void addRating() {
      showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          EdgeInsets padding = MediaQuery.of(context).padding;
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: 300 + padding.bottom,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color(0xFFFF9900),
                Color(0xFFBF001D),
                Color(0xFFA50F3D),
                Color(0xFF143A6B),
                Color(0xFF1F5286),
                Color(0xFF008DFF)
              ], stops: <double>[
                0,
                0.2,
                0.33,
                0.7,
                0.82,
                1
              ], begin: Alignment.bottomLeft, end: Alignment.topRight),
            ),
            child: Column(children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Califique la película:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.star_rounded,
                              size: 90,
                              color: Color.fromRGBO(0, 123, 222, 1),
                            ),
                          ),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 34),
                            child: Text(
                              _rating.toStringAsFixed(0),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -1.5),
                            ),
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          10,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _rating = index + 1;
                              });
                            },
                            child: StarIcon(
                              filled: index < _rating,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          _rating == 0 ? {} : {Navigator.pop(context)};
                        },
                        child: Opacity(
                          opacity: _rating == 0 ? 0.35 : 1,
                          child: Container(
                            width: 110,
                            height: 45,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(109, 0, 0, 1),
                                      Color.fromRGBO(255, 0, 0, 1),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(4, 4),
                                      blurRadius: 6,
                                      color: Color.fromRGBO(0, 0, 0, .35))
                                ]),
                            child: const Center(
                                child: Text(
                              "Enviar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      )
                    ],
                  );
                },
              )
            ]),
          );
        },
      );
    }

    Future<void> uploadFile(File file) async {
      var url = Uri.parse('http://192.168.18.12:3333/subirFotoVisita');
      var request = http.MultipartRequest('POST', url);

      var stream = http.ByteStream.fromBytes(file.readAsBytesSync());
      var length = await file.length();

      var multipartFile = http.MultipartFile('file', stream, length,
          filename: file.path.split('/').last);

      request.files.add(multipartFile);

      try {
        var response = await request.send();

        if (response.statusCode == 200) {
          setState(() {
            isPictureSending = false;
          });
          addRating();
        } else {
          print('Failed to upload file. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error uploading file: $error');
      }
    }

    return Scaffold(
        body: _isBackdropLoaded
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
                        _isBackdropLoaded = true;
                      }
                      return child;
                    }),
                  ),
                ),
                Positioned(
                  top: 215,
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
                          height: 8,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Detalles de función",
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
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
                          height: 25,
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
                                    fontSize: 24,
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
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    _chooseImage();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 280,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors: [
                                              Color.fromRGBO(1, 136, 144, 1),
                                              Color.fromRGBO(72, 38, 170, 1)
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter),
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(4, 4),
                                              blurRadius: 4,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.35))
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.camera,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            imageFile == null
                                                ? "Cargar foto"
                                                : "Foto cargada!",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Opacity(
                                opacity: imageFile != null ? 1 : 0.35,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      imageFile != null
                                          ? (() {
                                              uploadFile(imageFile!);
                                              setState(() {
                                                isPictureSending = true;
                                              });
                                            })()
                                          : {};
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 280,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(0, 47, 90, 1),
                                                  Color.fromRGBO(
                                                      53, 175, 116, 1)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter),
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(4, 4),
                                                  blurRadius: 4,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.35))
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            isPictureSending
                                                ? const SizedBox(
                                                    height: 15,
                                                    width: 15,
                                                    child:
                                                        CircularProgressIndicator(
                                                            strokeWidth: 3,
                                                            color:
                                                                Colors.white))
                                                : const Icon(
                                                    Icons.done_rounded,
                                                    color: Colors.white,
                                                  ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: Text(
                                                isPictureSending
                                                    ? "Enviando..."
                                                    : "Marcar como finalizada",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
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
