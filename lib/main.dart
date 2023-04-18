import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playground/mainPage.dart';
import 'package:playground/splash.dart';
import 'colors.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlayGround',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: createMaterialColor(mColor1),
        appBarTheme: AppBarTheme(
          color: Colors.white, //<-- SEE HERE
        ),
      ),
      home: SplashScreen(), //for debug
      //home: MainPage('test','TEST FULL'),
    );
  }
}

