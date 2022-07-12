import 'package:dwr0001/Application/Map/map.dart';
import 'package:dwr0001/Application/MenuOld.dart';
import 'package:dwr0001/components/burgerMenu/widgetMenuItem.dart';
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
            ),
            buildMenuItem(
              text: "แผนที่",
              icon: Icons.map,
              Path: MapPage(),
            ),
            buildMenuItem(
              text: "ลุ่มแม่น้ำ",
              icon: Icons.water_drop_outlined,
              Path: MapPage(),
            ),
          ],
        ),
      ),
    );
  }
}
