import 'package:flutter/material.dart';
import 'package:payments/pages/finish_page.dart';
import 'package:payments/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stripe App',
      initialRoute: FinishPagePage.routeName,
      routes: {
        HomePage.routeName: (_) => HomePage(),
        FinishPagePage.routeName: (_) => FinishPagePage(),
      },
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey,
        scaffoldBackgroundColor: Color(0xff21232A)
      ),
    );
  }
}