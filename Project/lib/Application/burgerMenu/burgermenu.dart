import 'package:dwr0001/Application/MenuOld.dart';
import 'package:flutter/material.dart';

class NavigationBurgerMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                SizedBox(width: 30),
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 60,
                ),
                SizedBox(width: 10),
                Text(
                  "TeleDWR",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(color: Colors.black38),
            buildMenuItem(
              text: "หน้าหลัก",
              icon: Icons.home_filled,
              Path: MenuPageOld(data: ''),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {String text, IconData icon, var Path, BuildContext context}) {
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
