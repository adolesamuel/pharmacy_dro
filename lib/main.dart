import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pharmacy/app/pages/pharm_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ///This widget is the root of your application.
  ///This app is using an abridged version of Reso Coder's clean architecture
  ///The cart is a Hive box
  ///Should have used Getit for dependency injection of the blocs but this way has less boilerplate code.
  /// Data is gotten from a assets used as mock remote data source
  /// Drug Images exists as assets in the assets folder
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Proxima-Nova',
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: PharmacyPage(),
    );
  }
}
