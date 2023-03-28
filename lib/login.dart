import 'package:flutter/material.dart';

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
                Text("Play",style: TextStyle(fontFamily: 'Pacifico',fontSize: 40,color: mColor1)),
                Text("Ground.com", style: TextStyle(fontFamily: 'Pacifico',fontSize: 40,color: mColor2))
              ],
            ),
            SizedBox(height: 60,),
            Container(
              width: 400,
              child: TextField(controller: idController,decoration: _fieldDecoration("ID or Email Adress"),style: TextStyle(fontSize: 20,color: Colors.black38),),
              height: 50,
            ),
            SizedBox(height: 10,),
            Container(
                width: 400,
                child: TextField(controller: pwController,decoration: _fieldDecoration("Password"),style: TextStyle(fontSize: 20,color: Colors.black38),obscureText: true,),
              height: 50,
            ),
            SizedBox(height: 40,),
            Container(
              width: 400,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Login', style: TextStyle(fontSize: 15),),
                style: ElevatedButton.styleFrom(
                  primary: mColor1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(400,50),
                  maximumSize: Size(400,50),
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