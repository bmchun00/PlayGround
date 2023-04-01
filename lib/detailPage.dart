import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget{
  String? cardId;
  @override
  State<StatefulWidget> createState() => _DetailPage(cardId!);

  DetailPage(String cId){
    cardId = cId;
  }
}

class _DetailPage extends State<StatefulWidget>{
  String? cardId;

  _DetailPage(String cId){
    cardId = cId;
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Text("Detail Page / arguments (CardId) : ${cardId}"),
    );
  }
}