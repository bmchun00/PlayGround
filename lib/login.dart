import 'package:flutter/material.dart';

import 'mainPage.dart';
import 'splash.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
  TextEditingController? idController;
  TextEditingController? pwController;

  @override
  void initState(){
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
  }
  _fieldDecoration(String hintTxt){
    return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10, 4, 0, 0),
      fillColor: Color.fromRGBO(0, 0, 0, 0.050980392156862744),
      filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide:
      BorderSide(width: 1, color: Colors.transparent), //<-- SEE HERE
      borderRadius: BorderRadius.circular(50.0),
      ),focusedBorder: OutlineInputBorder(
      borderSide:
      BorderSide(width: 1, color: mColor1), //<-- SEE HERE
      borderRadius: BorderRadius.circular(50.0),
    ),
      hintText: hintTxt,
      hintStyle: TextStyle(fontSize: 20.0, color: Color.fromRGBO(0, 0, 0, 0.10980392156862744),),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Play",style: TextStyle(fontFamily: 'Pacifico',fontSize: 35,color: mColor1)),
                Text("Ground.com", style: TextStyle(fontFamily: 'Pacifico',fontSize: 35,color: mColor2))
              ],
            ),
            SizedBox(height: 55,),
            Container(
              width: 300,
              child: TextField(textAlignVertical: TextAlignVertical.center, controller: idController,decoration: _fieldDecoration("ID or Email Address"),style: TextStyle(fontSize: 17,color: Colors.black38),),
              height: 40,
            ),
            SizedBox(height: 10,),
            Container(
                width: 300,
                child: TextField(textAlignVertical: TextAlignVertical.center, controller: pwController,decoration: _fieldDecoration("Password"),style: TextStyle(fontSize: 17,color: Colors.black38),obscureText: true,),
              height: 40,
            ),
            SizedBox(height: 40,),
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainPage()));
                },
                child: const Text('Login', style: TextStyle(fontSize: 15),),
                style: ElevatedButton.styleFrom(
                  primary: mColor1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(300,40),
                  maximumSize: Size(300,40),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Doesn't have an account? ",style: TextStyle(color: Colors.black45),),
                Text("Sign up",style: TextStyle(color: mColor2),)
              ],
            )
          ],
        ),
      )
    );
  }
}