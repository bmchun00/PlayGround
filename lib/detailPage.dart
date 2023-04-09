import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

class DetailPage extends StatefulWidget{
  Map<dynamic,dynamic> data;
  @override
  State<StatefulWidget> createState() => _DetailPage(data);

  DetailPage(this.data);
}

Widget getCard(Map data){
  return Card(
      shape: RoundedRectangleBorder(
      ),
      child: Column(
        children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child:
                  Container(height: 60,width: 60, decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(image: AssetImage(data['image']),fit: BoxFit.cover)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['fullName'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data['type'], style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
                        Text(' | ', style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
                        Text(data['userId'], style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text(DateFormat.yMMMd().add_jm().format(data['time']), style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),

                  ],
                ),
              ],
            ),Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(),
                  Text(data['title'], style: TextStyle(fontSize: 20, fontFamily: 'SCDream', fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text(data['content'], style: TextStyle(fontSize: 17, fontFamily: 'SCDream'), ),

                ],
              ),
            ),
          Padding(padding: EdgeInsets.fromLTRB(12,0,0,20),
            child: Row(
              children: [
                IconButton(icon : Icon(Icons.favorite_border), onPressed: (){
                  },splashRadius: 15,),
                SizedBox(width: 3,),
                Text(data['like'].toString(), style: TextStyle(fontFamily: 'SCDream', fontSize: 15),),
                SizedBox(width: 30,),
                IconButton(icon: Icon(Icons.messenger_outline_rounded), onPressed: () {  }, splashRadius: 15,),
                SizedBox(width: 3,),
                Text(data['comment'].toString(), style: TextStyle(fontFamily: 'SCDream', fontSize: 15),),
              ],
            ),
          ),
        ],
      )
  );
}

class _DetailPage extends State<StatefulWidget>{
  Map data;

  _DetailPage(this.data);

  Widget build(BuildContext context){
    return Scaffold(
        appBar:AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), color: mColor1, onPressed: () { Navigator.of(context).pop(); },),
          centerTitle: true,
          elevation: 0,
          title: Row(mainAxisSize: MainAxisSize.min,mainAxisAlignment:MainAxisAlignment.center,children: [Text("Play", style: TextStyle(color: mColor1, fontFamily: 'Pacifico'),),Text("Ground", style: TextStyle(color: mColor2, fontFamily: 'Pacifico'),),]),
          toolbarHeight: 50,
        ),
      body: getCard(data)
    );

  }
}