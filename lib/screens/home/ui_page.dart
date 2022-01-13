import 'package:flutter/material.dart';

class UIPage extends StatefulWidget {
  //!c: const UIPage({ Key? key }) : super(key: key);

  @override
  _UIPageState createState() => _UIPageState();
}

class _UIPageState extends State<UIPage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(
        xOffset,
        yOffset,
        0,
      )
        ..scale(scaleFactor)
        ..rotateY(
          isDrawerOpen ? -0.7 : 0,
        ),
      duration: const Duration(
        milliseconds: 250,
      ),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.deepPurple,
            blurRadius: 20,
            spreadRadius: 5,
            offset: Offset(-15, 10),
          ),
          BoxShadow(
            color: Colors.deepPurple,
            blurRadius: 20,
            spreadRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(
          isDrawerOpen ? 50 : 0,
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isDrawerOpen
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            xOffset = 0;
                            yOffset = 0;
                            scaleFactor = 1;
                            isDrawerOpen = false;
                          });
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            xOffset = MediaQuery.of(context).size.width * .6;
                            yOffset = MediaQuery.of(context).size.height * .15;
                            scaleFactor = .7;
                            isDrawerOpen = true;
                          });
                        },
                        child: const Icon(
                          Icons.menu,
                          size: 25,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
