import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sked/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sked/models/modelo_visita.dart';

class FuncionesPasadas extends StatefulWidget {
  const FuncionesPasadas({super.key});

  @override
  State<FuncionesPasadas> createState() => _FuncionesPasadasState();
}

class _FuncionesPasadasState extends State<FuncionesPasadas> {
  @override
  Widget build(BuildContext context) {
    final dataModel = Provider.of<DataModel>(context);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25, bottom: 25),
                child: const Text(
                  "Funciones pasadas",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 45),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: FutureBuilder(
                    future: dataModel.fetchDataFromAPI(),
                    builder: (context, snapshot) {
                      final List<dynamic> pictures =
                          snapshot.data?.fotosVisitas ?? [];
                      final List<ModeloVisita> visits =
                          snapshot.data?.visitas ?? [];
                      return visits.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Container(
                                constraints: const BoxConstraints.expand(),
                                child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "¡No hay funciones pasadas!",
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
                                        Icons.no_cell_rounded,
                                        color: Colors.white,
                                        size: 60,
                                      )
                                    ]),
                              ),
                            )
                          : ListView.builder(
                              itemCount: pictures.length,
                              itemBuilder: (context, index) {
                                final picture = pictures[index];
                                final visit = visits[index];
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 40,
                                      right: 40,
                                      bottom: index == pictures.length - 1
                                          ? 20
                                          : 35),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 230,
                                        decoration:
                                            const BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            offset: Offset(5, 5),
                                            blurRadius: 9.5,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.65),
                                          )
                                        ]),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                      child: SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.6,
                                                    child: CachedNetworkImage(
                                                      imageUrl: picture,
                                                      placeholder: (context,
                                                              url) =>
                                                          const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                        color: Colors.white,
                                                      )),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ));
                                                },
                                              );
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl: picture,
                                              placeholder: (context, url) =>
                                                  const SizedBox(
                                                width: 120,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: Colors.white,
                                                )),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.videocam,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 1.5),
                                                    child: Text(
                                                      visit.title,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.location_on_rounded,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 1.5),
                                                    child: Text(
                                                      visit.cinema,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star_rate_rounded,
                                                  color: Colors.amber,
                                                  size: 27,
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 7),
                                                    child: Text(
                                                      visit.userRating
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 21,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
