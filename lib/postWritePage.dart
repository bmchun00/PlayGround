import 'package:flutter/material.dart';
import 'colors.dart';


class PostWritePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PostWritePage();
}

class _PostWritePage extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        leading: Text("Back"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(mainAxisAlignment:MainAxisAlignment.center, children: [Text("Play", style: TextStyle(color: mColor1, fontFamily: 'Pacifico'),),Text("Ground", style: TextStyle(color: mColor2, fontFamily: 'Pacifico'),),],),
      ),
    );
  }
}