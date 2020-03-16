import 'package:flutter/material.dart';

Color showColorByRate(String color) {
  switch (color) {
    case 'red':
      return Colors.red;
    case 'orange':
      return Colors.orange;
    case 'yellow':
      return Colors.yellow;
    case 'blue':
      return Colors.blue;
    case 'cyan':
      return Colors.cyan;
    case 'green':
      return Colors.green;
    case 'brown':
      return Colors.brown;
  }
  return Colors.grey;
}

