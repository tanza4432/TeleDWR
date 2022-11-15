import 'package:dwr0001/Application/providers/map_provider.dart';
import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/screen/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RiverProviderTabOne(),
        ),
        ChangeNotifierProvider(
          create: (context) => RiverProviderTabTwo(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteRiver(),
        ),
        ChangeNotifierProvider(
          create: (context) => MapProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TeleDWR',
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: Welcome(),
      ),
    );
  }
}
