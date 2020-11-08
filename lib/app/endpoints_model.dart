import 'package:flutter/material.dart';
import 'package:jacovida/app/services/api.dart';

class EndPointsData {
  final Map<EndPoint, int> values;

  EndPointsData({@required this.values});

  int get cases => values[EndPoint.cases];
  int get casesConfirmed => values[EndPoint.casesConfirmed];
  int get casesSuspected => values[EndPoint.casesSuspected];
  int get deaths => values[EndPoint.deaths];
  int get recovered => values[EndPoint.recovered];

  @override
  String toString() =>
      'case: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
