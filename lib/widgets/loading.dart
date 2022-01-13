import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  //!c: const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: SpinKitFadingCircle(
          color: Colors.black,
          size: 30,
          duration: Duration(
            seconds: 10,
          ),
        ),
      ),
    );
  }
}
