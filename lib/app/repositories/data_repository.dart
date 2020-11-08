import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jacovida/app/endpoints_model.dart';
import 'package:jacovida/app/services/api.dart';
import 'package:jacovida/app/services/api_service.dart';
import 'package:jacovida/app/services/end_pointdata.dart';

class DataRepository {
  final APIService apiService;

  String _token = '';

  DataRepository({@required this.apiService});

  /// gets the int value by end point
  Future<EndPointData> getData(EndPoint endPoint) async =>
      await _getToken<EndPointData>(
        onGetData: () =>
            apiService.getEndPointData(token: _token, endPoint: endPoint),
      );

  Future<EndPointsData> getAllEndPointsData() async =>
      await _getToken<EndPointsData>(
        onGetData: _getAllEndPointsData,
      );

  Future<EndPointsData> _getAllEndPointsData() async {
    final values = await Future.wait([
      apiService.getEndPointData(
        token: _token,
        endPoint: EndPoint.cases,
      ),
      apiService.getEndPointData(
        token: _token,
        endPoint: EndPoint.casesConfirmed,
      ),
      apiService.getEndPointData(
          token: _token, endPoint: EndPoint.casesSuspected),
      apiService.getEndPointData(
        token: _token,
        endPoint: EndPoint.deaths,
      ),
      apiService.getEndPointData(
        token: _token,
        endPoint: EndPoint.recovered,
      ),
    ]);

    return EndPointsData(values: {
      EndPoint.cases: values[0],
      EndPoint.casesConfirmed: values[1],
      EndPoint.casesSuspected: values[2],
      EndPoint.deaths: values[3],
      EndPoint.recovered: values[4],
    });
  }

  Future<T> _getToken<T>({Future<T> Function() onGetData}) async {
    try {
      /// do we have a token?
      if (_token.isEmpty) {
        /// api throws a Response exception
        _token = await apiService.getAccessToken();
      }

      return await onGetData();
    } on Response catch (response) {
      /// has it expired?
      if (response.statusCode == 401) {
        _token = await apiService.getAccessToken();

        return onGetData();
      }

      /// unhandled exception, rethrow for the calling widget to handle
      rethrow;
    }
  }
}
