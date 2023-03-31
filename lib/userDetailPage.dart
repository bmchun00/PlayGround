import 'package:flutter/material.dart';

class UserDetailPage extends StatefulWidget{
  String? userId;
  @override
  State<StatefulWidget> createState() => _UserDetailPage(userId!);

  UserDetailPage(String uId){
    userId = uId;
  }
}

class _UserDetailPage extends State<StatefulWidget>{
  String? userId;

  _UserDetailPage(String uId){
    userId = uId;
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Text("This is Detail page for ${userId}"),
    );
  }
}