import 'package:flutter/material.dart';
import 'package:jacovida/app/endpoints_model.dart';
import 'package:jacovida/app/repositories/data_repository.dart';
import 'package:jacovida/app/services/api.dart';
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
    _updateData();
  }

  Future<void> _updateData() async {
    final repo = Provider.of<DataRepository>(context, listen: false);
    final cases = await repo.getAllEndPointsData();
    setState(() {
      _endPointsData = cases;
    });
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
                  ? _endPointsData.values[EndPoint.cases].date ?? ''
                  : '',
            ),
            for (var endPoint in EndPoint.values)
              EndPointCard(
                endPoint: endPoint,
                value: _endPointsData != null
                    ? _endPointsData.values[endPoint].value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
