import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sked/main.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "Funciones pasadas",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 35),
                ),
              ),
              // FutureBuilder(
              //   future: dataModel.fetchDataFromAPI(),
              //   builder: (context, snapshot) {
              //     final List<dynamic> pictures =
              //         snapshot.data?.fotosVisitas ?? [];
              //     return ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: pictures.length,
              //       itemBuilder: (context, index) {
              //         final picture = pictures[index];
              //         return CachedNetworkImage(
              //           imageUrl: picture,
              //           placeholder: (context, url) => CircularProgressIndicator(),
              //           errorWidget: (context, url, error) => Icon(Icons.error),
              //         );
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
