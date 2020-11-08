import 'package:flutter/material.dart';
import 'package:jacovida/app/services/api.dart';
import 'package:jacovida/app/services/end_pointdata.dart';

class EndPointsData {
  final Map<EndPoint, EndPointData> values;

  EndPointsData({@required this.values});

  EndPointData get cases => values[EndPoint.cases];
  EndPointData get casesConfirmed => values[EndPoint.casesConfirmed];
  EndPointData get casesSuspected => values[EndPoint.casesSuspected];
  EndPointData get deaths => values[EndPoint.deaths];
  EndPointData get recovered => values[EndPoint.recovered];

  @override
  String toString() =>
      'case: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
