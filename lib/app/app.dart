import 'package:flutter/material.dart';
import 'package:covid_app/routes/routes.dart';
import 'package:covid_app/screens/brazilSituation_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CovidApp',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black26,
      ),
      initialRoute: '/',
      routes: {
        MyRoutes.brazilSituation:(context) => const BrazilSituation(),
      },
    );
  }
}