import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jacovida/app/services/api.dart';

import 'package:http/http.dart' as http;

class APIService {
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<int> getEndPointData({@required token, EndPoint endPoint}) async {
    final uri = api.endPointUri(endPoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endPointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endPoint];
        final int result = endPointData[responseJsonKey];

        if (result != null) {
          return result;
        }
      }
    }

    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  static Map<EndPoint, String> _responseJsonKeys = {
    EndPoint.cases: 'cases',
    EndPoint.casesSuspected: 'data',
    EndPoint.casesConfirmed: 'data',
    EndPoint.deaths: 'data',
    EndPoint.recovered: 'data',
  };
}
