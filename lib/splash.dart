import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:playground/pageRouteAnimation.dart';
import 'login.dart';
import 'colors.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>{


  String? title1;
  String? title2;
  Widget? titleWidget1;
  Widget? titleWidget2;

  @override
  void initState(){
    super.initState();
    loadData();
    title1 = "";
    title2 = "";

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        titleWidget1 = getCustomAnimatedText("lay", mColor1,300);
        titleWidget2 = getCustomAnimatedText("round.com", mColor2,100);
      });
    });
  }

  Future<Timer> loadData() async{ //아직은 없지만 이때 각종 데이터들 받아옴
    return Timer(Duration(seconds: 5),onDoneLoading);
  }

  onDoneLoading(){ //자동 로그인이 설정되어있는 경우도 있음
    Navigator.of(context).pushReplacement(fadeRoute(LoginPage(), 500));
  }

  DefaultTextStyle getCustomAnimatedText(String text, Color color, int spd){
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 40.0,
        fontFamily: 'Pacifico',
        color: color,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(text, speed: Duration(milliseconds: spd)),
        ],
        repeatForever: false,
        totalRepeatCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Center(
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("P",style: TextStyle(fontFamily: 'Pacifico',fontSize: 40,color: mColor1),),
                titleWidget1 ?? Text(""),
                Text("G",style: TextStyle(fontFamily: 'Pacifico',fontSize: 40,color: mColor2),),
                titleWidget2 ?? Text(""),
              ],
            )
          )
        ),
      ),
    );
  }
}