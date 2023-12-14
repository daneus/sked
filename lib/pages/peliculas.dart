import 'package:flutter/material.dart';

class Peliculas extends StatelessWidget {
  const Peliculas({super.key});

  @override
  Widget build(BuildContext context) {
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
                margin: const EdgeInsets.only(top: 30, bottom: 15),
                child: const Text(
                  "Películas",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 50),
                ),
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                color: Colors.black,
              ))
            ],
          )),
        ),
      ),
    );
  }
}
