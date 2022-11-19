import 'package:dwr0001/Application/Map/map.dart';
import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Application/Setting/setting.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/components/burgerMenu/widgetMenuItem.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';

class NavigationBurgerMenuWidget extends StatefulWidget {
  final List<StationModel> data;
  final List<StationModel> notify;

  NavigationBurgerMenuWidget({
    Key key,
    @required this.data,
    @required this.notify,
  }) : super(key: key);

  @override
  State<NavigationBurgerMenuWidget> createState() =>
      _NavigationBurgerMenuWidgetState();
}

class _NavigationBurgerMenuWidgetState
    extends State<NavigationBurgerMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 30),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 60,
                ),
                SizedBox(width: 10),
                Text(
                  "TeleDWR",
                  style: DefaultTitleB(),
                )
              ],
            ),
            SizedBox(height: 20),
            Divider(color: Colors.black38),
            buildMenuItem(
              text: "หน้าหลัก",
              icon: Icons.home_filled,
              Path: MenuPage(data: widget.data, notify: widget.notify),
            ),
            buildMenuItem(
              text: "แผนที่",
              icon: Icons.map,
              Path: MapPage(data: widget.data, notify: widget.notify),
            ),
            buildMenuItem(
              text: "ตั้งค่า",
              icon: Icons.settings,
              Path: SettingPage(data: widget.data, notify: widget.notify),
            ),
          ],
        ),
      ),
    );
  }
}
