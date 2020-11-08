import 'package:flutter/material.dart';
import 'package:jacovida/app/repositories/data_repository.dart';
import 'package:jacovida/app/services/api.dart';
import 'package:jacovida/app/services/api_service.dart';
import 'package:jacovida/app/services/datacache_service.dart';
import 'package:jacovida/ui/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Intl.defaultLocale = 'en_GB';
  //await initializeDateFormatting();
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    sharedPreferences: sharedPrefs,
  ));
}

class MyApp extends StatelessWidget {
  final sharedPreferences;

  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),
        dataCacheService:
            DataCacheService(sharedPreferences: sharedPreferences),
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
