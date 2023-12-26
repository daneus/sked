import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sked/main.dart';
import 'package:sked/models/modelo_funcion.dart';

class Funciones extends StatefulWidget {
  final Function(int) onBodyChanged;
  final Function(ModeloFuncion) onFuncionSelected;
  const Funciones(
      {super.key,
      required this.onBodyChanged,
      required this.onFuncionSelected});

  @override
  State<Funciones> createState() => _FuncionesState();
}

class _FuncionesState extends State<Funciones> {
  @override
  Widget build(BuildContext context) {
    final dataModel = Provider.of<DataModel>(context);

    String getMonthAbbreviation(int month) {
      switch (month) {
        case 1:
          return 'ENE';
        case 2:
          return 'FEB';
        case 3:
          return 'MAR';
        case 4:
          return 'ABR';
        case 5:
          return 'MAY';
        case 6:
          return 'JUN';
        case 7:
          return 'JUL';
        case 8:
          return 'AGO';
        case 9:
          return 'SEP';
        case 10:
          return 'OCT';
        case 11:
          return 'NOV';
        case 12:
          return 'DIC';
        default:
          return '';
      }
    }

    List<String> getMonthAndDay(String dateString) {
      DateTime dateTime = DateTime.parse(dateString);
      String monthAbbreviation = getMonthAbbreviation(dateTime.month);
      String day = dateTime.day.toString();
      return [monthAbbreviation, day];
    }

    return Scaffold(
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Funciones",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 40),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: dataModel.fetchDataFromAPI(),
                builder: (context, snapshot) {
                  final List<ModeloFuncion> functions =
                      snapshot.data?.funciones ?? [];
                  return functions.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Container(
                            constraints: const BoxConstraints.expand(),
                            child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "¡No hay futuras funciones!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    Icons.notifications_off_rounded,
                                    color: Colors.white,
                                    size: 60,
                                  )
                                ]),
                          ),
                        )
                      : ListView.builder(
                          itemCount: functions.length,
                          itemBuilder: (context, index) {
                            final function = functions[index];
                            return GestureDetector(
                              onTap: () {
                                widget.onBodyChanged(4);
                                widget.onFuncionSelected(function);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 25, right: 25),
                                height: 115,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(0, 133, 124, 1),
                                          Color.fromRGBO(0, 93, 160, 1)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(3, 3),
                                          blurRadius: 6,
                                          color: Color.fromRGBO(0, 0, 0, 0.45))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 20),
                                  child: Row(children: [
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Stack(children: [
                                        Image.asset('assets/calendar.png'),
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          top: 12,
                                          child: Center(
                                            child: Text(
                                              getMonthAndDay(
                                                  function.functionDate)[0],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 14,
                                          right: 14,
                                          bottom: 13,
                                          child: Container(
                                            color: const Color.fromRGBO(
                                                236, 240, 241, 1),
                                            width: 60,
                                            height: 35,
                                            child: Center(
                                                child: Text(
                                              getMonthAndDay(
                                                  function.functionDate)[1],
                                              style: const TextStyle(
                                                  fontSize: 30.5,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: -1),
                                            )),
                                          ),
                                        )
                                      ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                function.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            function.format == "IMAX"
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          color: Colors.white,
                                                        ),
                                                        width: 60,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Image.asset(
                                                            'assets/imaxLogo.png',
                                                            width: 30,
                                                          ),
                                                        )),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromRGBO(
                                                            78, 124, 193, 0.7),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: const Color
                                                                .fromRGBO(
                                                                0, 79, 197, 1)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6)),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                5, 3, 5, 1),
                                                        child: Text(
                                                          function.format,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                function.cinema,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    fontSize: 14.5),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.watch_later_outlined,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(function.functionTime,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      color: Colors.white)),
                                            )
                                          ],
                                        )
                                      ],
                                    ))
                                  ]),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
