import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'mainPage.dart';
import 'colors.dart';

class CreateAccountPage extends StatefulWidget{
  @override
  State<CreateAccountPage> createState() => _CreatAccountPage();
}

class _CreatAccountPage extends State<CreateAccountPage>{
  TextEditingController? _idController;
  TextEditingController? _nameController;
  TextEditingController? _pw1Controller;
  TextEditingController? _pw2Controller;

  @override
  void initState(){
    super.initState();
    _firebaseSetting();

    _idController = TextEditingController();
    _nameController = TextEditingController();
    _pw1Controller = TextEditingController();
    _pw2Controller = TextEditingController();
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
  void uploadLoginData() async{
    if(_pw1Controller!.value.text == _pw2Controller!.value.text){
      await db.collection("users").add({'fullname' : _nameController!.value.text , 'id' : _idController!.value.text, 'pw' : _pw1Controller!.value.text, 'image' : ""}).then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
      Navigator.of(context).pop();
    }
  }

  void _firebaseSetting() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
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
                child: TextField(textAlignVertical: TextAlignVertical.center, controller: _nameController,decoration: _fieldDecoration("Full Name"),style: TextStyle(fontSize: 17,color: Colors.black38),),
                height: 40,
              ),
              SizedBox(height: 10,),
              Container(
                width: 300,
                child: TextField(textAlignVertical: TextAlignVertical.center, controller: _idController,decoration: _fieldDecoration("ID or Email Address"),style: TextStyle(fontSize: 17,color: Colors.black38),),
                height: 40,
              ),
              SizedBox(height: 10,),
              Container(
                width: 300,
                child: TextField(textAlignVertical: TextAlignVertical.center, controller: _pw1Controller,decoration: _fieldDecoration("Password"),style: TextStyle(fontSize: 17,color: Colors.black38),obscureText: true,),
                height: 40,
              ),
              SizedBox(height: 10,),
              Container(
                width: 300,
                child: TextField(textAlignVertical: TextAlignVertical.center, controller: _pw2Controller,decoration: _fieldDecoration("Confirm Password"),style: TextStyle(fontSize: 17,color: Colors.black38),obscureText: true,),
                height: 40,
              ),
              SizedBox(height: 40,),
              Container(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    uploadLoginData();
                  },
                  child: const Text('Submit', style: TextStyle(fontSize: 15),),
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
            ],
          ),
        )
    );
  }
}