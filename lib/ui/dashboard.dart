import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jacovida/app/endpoints_model.dart';
import 'package:jacovida/app/repositories/data_repository.dart';
import 'package:jacovida/app/services/api.dart';
import 'package:jacovida/ui/alert_dialog.dart';
import 'package:jacovida/ui/endpoint_card.dart';
import 'package:jacovida/ui/timestamp.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndPointsData _endPointsData;

  @override
  void initState() {
    super.initState();
    final repo = Provider.of<DataRepository>(context, listen: false);
    _endPointsData = repo.getAllEndPointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final repo = Provider.of<DataRepository>(context, listen: false);
      final cases = await repo.getAllEndPointsData();
      setState(() {
        _endPointsData = cases;
      });
    } on SocketException catch (_) {
      await showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Unable to retrieve data. please try again later',
        defaultActionText: 'OK',
      );
    } catch (e) {
      await showAlertDialog(
        context: context,
        title: 'Unknown Exception',
        content: '${e.toString()}',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdatedStatusString(
              text: _endPointsData != null
                  ? _endPointsData.values[EndPoint.cases]?.date ?? ''
                  : '',
            ),
            for (var endPoint in EndPoint.values)
              EndPointCard(
                endPoint: endPoint,
                value: _endPointsData != null
                    ? _endPointsData.values[endPoint]?.value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
