import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';

class BoxDetail extends StatelessWidget {
  String title;
  var path;

  BoxDetail({
    Key key,
    @required this.title,
    @required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => path,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.lightBlue[600],
          boxShadow: [
            BoxShadow(
              spreadRadius: 3,
              color: Colors.lightBlue[600],
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 5, left: 5),
          child: Text(
            title,
            style: DefaultStyleW(),
          ),
        ),
      ),
    );
  }
}
