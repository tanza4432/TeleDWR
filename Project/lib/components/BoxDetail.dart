import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';

class BoxDetail extends StatelessWidget {
  String title;
  var path;
  String checkFound;

  BoxDetail({
    Key key,
    @required this.title,
    @required this.path,
    @required this.checkFound,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (checkFound != "") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => path,
            ),
          );
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              title: Column(
                children: [
                  Text("ไม่พบข้อมูล", style: DefaultStyleB()),
                ],
              ),
            ),
          );
        }
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
          child: Row(
            children: [
              Text(
                title,
                style: DefaultStyleW(),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
