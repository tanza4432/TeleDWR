import 'package:dwr0001/Application/providers/map_provider.dart';
import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/screen/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
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
        ChangeNotifierProvider(
          create: (context) => NotificationRiver(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TeleDWR',
        home: Welcome(),
      ),
    );
  }
}
