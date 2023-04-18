import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playground/mainPage.dart';
import 'colors.dart';

class DetailPage extends StatefulWidget{
  Map<dynamic,dynamic> data;
  String id;
  String name;
  @override
  State<StatefulWidget> createState() => _DetailPage(data,id,name);

  DetailPage(this.data, this.id, this.name);
}

class _DetailPage extends State<StatefulWidget>{
  Map data;
  String id;
  String name;
  List commentDataList = List.empty(growable: true);
  TextEditingController _commentController = TextEditingController();

  void getCommentData() async{
    await _getComment(data['cardId']);
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommentData();
  }

  List<Widget> getImgList(List imgs){
    List<Widget> toRet = [];
    imgs.forEach((item) {
      toRet.add(
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Image.memory(base64Decode(item)),)
      );
    });
    return toRet;
  }

  Widget getCard(Map data){
    return Card(
        shape: RoundedRectangleBorder(
        ),
        child: ListView(
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
            ListView(
              shrinkWrap: true,
              physics : NeverScrollableScrollPhysics(),
              children: getImgList(data['imgs']),
            ),
            Padding(padding: EdgeInsets.fromLTRB(12,0,0,12),
              child: Row(
                children: [
                  IconButton(icon : Icon(Icons.favorite_border), onPressed: (){
                  },splashRadius: 15,),
                  SizedBox(width: 3,),
                  Text(data['like'].toString(), style: TextStyle(fontFamily: 'SCDream', fontSize: 15),),
                  SizedBox(width: 30,),
                  IconButton(icon: Icon(Icons.messenger_outline_rounded), onPressed: () {  }, splashRadius: 15,),
                  SizedBox(width: 3,),
                  //Text(data['comment'].toString(), style: TextStyle(fontFamily: 'SCDream', fontSize: 15),),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 5), child: Row(
              children: [
                Container(height: 40,width: 40, decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(image: AssetImage(data['image']),fit: BoxFit.cover)),
                ),
                SizedBox(width: 20,),
                Flexible(child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  ),
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'SCDream',
                  ),
                  controller: _commentController,
                )),
                SizedBox(width: 10,),
                IconButton(onPressed: (){
                  if(_commentController.value.text != "") {
                    _LeaveComment(_commentController.value.text);
                    _commentController.clear();
                  }
                }, icon: Icon(Icons.send, color: mColor1,)),
              ],
            ),
            ),
            Divider(),
            SizedBox(height: 5,),
            Container(child: ListView.builder(
              shrinkWrap : true,
              physics : NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index){
                return Padding(padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(height: 20,width: 20, decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                image: DecorationImage(image: AssetImage(data['image']),fit: BoxFit.cover)),
                            ),
                            SizedBox(width: 10,),
                            Text(commentDataList[index]['userName'],overflow: TextOverflow.fade, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          children: [
                            Row(),
                            Text(commentDataList[index]['content'], textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontFamily: 'SCDream'),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text(DateFormat.yMMMd().add_jm().format(commentDataList[index]['time']), textAlign: TextAlign.start, style: TextStyle(fontSize: 10,fontFamily: 'SCDream',color: Colors.grey),),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                );
              },
              itemCount: commentDataList.length,
            ))
          ],
        )
    );
  }

  _DetailPage(this.data, this.id, this.name);

  _getComment(String cId) async{
    await db.collection("comments").where("postId",isEqualTo: cId).orderBy("time", descending: true).get().then((event) {
      commentDataList = List.empty(growable: true);
      for (var doc in event.docs) {
        var data = doc.data();
        commentDataList.add({'content' : data['content'], 'postId' : data['postId'], 'userId' : data['userId'], 'time' : DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000), 'userName' : data['userName'],});
      }
    });
  }

  _LeaveComment(String content) async {
      await db.collection("comments").add({'content' : content, 'postId' : data['cardId'], 'userId' : id, 'time' : Timestamp.fromDate(DateTime.now()), 'userName' : name}).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
      await _getComment(data['cardId']);
      setState(() {
      });
  }

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