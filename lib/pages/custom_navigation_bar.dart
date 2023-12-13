import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            margin: const EdgeInsets.only(bottom: 25, left: 70, right: 70),
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(12, 66, 148, 0.55),
                  borderRadius: BorderRadius.circular(30)),
              child: SizedBox(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(5, 23, 87, .5),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          size: 32,
                          Icons.local_movies_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(5, 23, 87, 0.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          size: 32,
                          Icons.movie_creation_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(5, 23, 87, 0.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          size: 32,
                          Icons.movie_filter_rounded,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
