import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';

class BoxAbout extends StatelessWidget {
  String title;
  var icon;
  var path;

  BoxAbout({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black26,
      ),
      onPressed: path,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  title,
                  style: DefaultStyleB(),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
