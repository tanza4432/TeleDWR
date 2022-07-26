import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSquareCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Center(
        child: SpinKitSquareCircle(
          color: Colors.blue[300],
          size: 50.0,
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size.height * 0.81,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingSquareCircle(),
        ],
      ),
    );
  }
}
