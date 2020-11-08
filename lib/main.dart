import 'package:flutter/material.dart';
import 'package:jacovida/app/repositories/data_repository.dart';
import 'package:jacovida/app/services/api.dart';
import 'package:jacovida/app/services/api_service.dart';
import 'package:jacovida/ui/dashboard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid-19 Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
