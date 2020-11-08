import 'package:flutter/material.dart';
import 'package:jacovida/app/endpoints_model.dart';
import 'package:jacovida/app/services/api.dart';
import 'package:jacovida/app/services/end_pointdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  final SharedPreferences sharedPreferences;

  DataCacheService({@required this.sharedPreferences});

  static String endPointValueKey(EndPoint endPoint) => '$endPoint/value';
  static String endPointDateKey(EndPoint endPoint) => '$endPoint/date';

  /// de-serialize
  EndPointsData getData() {
    Map<EndPoint, EndPointData> values = {};

    EndPoint.values.forEach((endpoint) {
      var value = sharedPreferences.getInt(endPointValueKey(endpoint));
      var dateString = sharedPreferences.getString(endPointDateKey(endpoint));

      if (value != null && dateString != null) {
        var date = DateTime.tryParse(dateString);
        values[endpoint] = EndPointData(value: value, date: date);
      }
    });

    return EndPointsData(values: values);
  }

  /// serialize the data
  Future<void> setData(EndPointsData endPointsData) async {
    endPointsData.values.forEach((endpoint, endPointData) async {
      await sharedPreferences.setInt(
          endPointValueKey(endpoint), endPointData.value);

      await sharedPreferences.setString(
          endPointDateKey(endpoint), endPointData.date.toIso8601String());
    });
  }
}
