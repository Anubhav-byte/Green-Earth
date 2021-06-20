import 'package:flutter/material.dart';
import 'package:greenhacks/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        appBarTheme: _appBarTheme(),
        cardTheme: _cardTheme(),
        scaffoldBackgroundColor:Colors.transparent,
        floatingActionButtonTheme: _floatingActionButtonTheme(),


      ),
      home: Home(),
    );
  }

  _appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,

    );
  }

  _cardTheme() {
    return CardTheme(
      elevation: 6,
      shadowColor:Colors.grey,
      margin: EdgeInsets.only(top: 10.1, bottom: 8,left: 10,right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.green,
          width: 0.3
        )

      )
    );
  }

  _floatingActionButtonTheme() {
    return FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colors.green
    );
  }

}


