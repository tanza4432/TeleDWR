import 'package:flutter/material.dart';

class buildMenuItem extends StatelessWidget {
  String text;
  IconData icon;
  var Path;

  buildMenuItem(
      {Key key, @required this.text, @required this.icon, @required this.Path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black45),
      title: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Path));
      },
    );
  }
}
