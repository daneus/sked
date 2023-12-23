import 'package:flutter/material.dart';
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
                Column(
                  children: [
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
                  ],
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
