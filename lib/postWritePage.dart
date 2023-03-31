import 'package:flutter/material.dart';

class PostWritePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PostWritePage();
}

class _PostWritePage extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("new Post"),
      ),
    );
  }
}