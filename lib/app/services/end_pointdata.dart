import 'package:flutter/material.dart';

class EndPointData {
  final int value;
  final DateTime date;

  EndPointData({@required this.value, this.date}) : assert(value != null);

  @override
  String toString() {
    return 'date: $date, value $value';
  }
}
