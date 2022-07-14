import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/screen/welcome/welcomeold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RiverProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'mytitle',
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: WelcomeOld(),
      ),
    );
  }
}
