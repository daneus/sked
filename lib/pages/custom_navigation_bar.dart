import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(int) onBodyChanged;

  // ignore: prefer_const_constructors_in_immutables
  CustomNavigationBar(this.onBodyChanged, {super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  void changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            margin: const EdgeInsets.only(bottom: 30, left: 70, right: 70),
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
                      child: Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: _selectedIndex == 0 ? .5 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(5, 23, 87, 1),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          Center(
                            child: IconButton(
                                onPressed: () {
                                  changeIndex(0);
                                  widget.onBodyChanged(0);
                                },
                                icon: const Icon(
                                  Icons.local_movies_rounded,
                                  size: 32,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: _selectedIndex == 1 ? .5 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(5, 23, 87, 1),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          Center(
                            child: IconButton(
                                onPressed: () {
                                  changeIndex(1);
                                  widget.onBodyChanged(1);
                                },
                                icon: const Icon(
                                  Icons.movie_creation_outlined,
                                  size: 32,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: _selectedIndex == 2 ? .5 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(5, 23, 87, 1),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          Center(
                            child: IconButton(
                                onPressed: () {
                                  changeIndex(2);
                                  widget.onBodyChanged(2);
                                },
                                icon: const Icon(
                                  Icons.movie_filter_rounded,
                                  size: 32,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
