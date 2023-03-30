import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget{
  int? cardId;
  @override
  State<StatefulWidget> createState() => _DetailPage(cardId!);

  DetailPage(int cId){
    cardId = cId;
  }
}

class _DetailPage extends State<StatefulWidget>{
  int? cardId;

  _DetailPage(int cId){
    cardId = cId;
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Text("Detail Page / arguments (CardId) : ${cardId}"),
    );
  }
}