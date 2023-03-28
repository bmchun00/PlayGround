import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'login.dart';

Color mColor1 = Color.fromRGBO(255, 198, 168, 1);
Color mColor2 = Color.fromRGBO(183, 215, 216, 1);

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>{
  String? title;

  @override
  void initState(){
    super.initState();
    loadData();
    title = "";
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        title = "Ground.com";
      });
    });
  }

  Future<Timer> loadData() async{ //아직은 없지만 이때 각종 데이터들 받아옴
    return Timer(Duration(seconds: 5),onDoneLoading);
  }

  onDoneLoading() async { //자동 로그인이 설정되어있는 경우도 있음
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
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
                Text("Play",style: TextStyle(fontFamily: 'Pacifico',fontSize: 40,color: mColor1),),
                DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Pacifico',
                      color: mColor2,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(title!, speed: Duration(milliseconds: 70)),
                      ],
                      onTap: () {
                      },
                      isRepeatingAnimation: true,
                    ),
                ),
              ],
            )
          )
        ),
      ),
    );
  }
}