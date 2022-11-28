import 'package:flutter/material.dart';

class swColor {
  static Color switchColor(station) {
    switch (station) {
      case "0":
        return Colors.green;
      case "1":
        return Colors.yellow;

      case "2":
        return Colors.red;

      case "3":
        return Colors.white;

      case "4":
        return Colors.grey;

      case "5":
        return Colors.black;

      case "6":
        return Colors.yellow;

      case "7":
        return Colors.red;
    }
  }

  static Color WLColor(station) {
    switch (station) {
      case "0":
        return Color.fromARGB(255, 35, 119, 36);
      case "1":
        return Color.fromARGB(255, 240, 220, 40);

      case "2":
        return Colors.red;

      case "3":
        return Colors.white;

      case "4":
        return Colors.grey;

      case "5":
        return Colors.black;

      case "6":
        return Color.fromARGB(255, 240, 220, 40);

      case "7":
        return Color.fromARGB(255, 183, 25, 14);
    }
  }
}
