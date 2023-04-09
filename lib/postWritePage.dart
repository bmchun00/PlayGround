import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playground/mainPage.dart';
import 'colors.dart';



class PostWritePage extends StatefulWidget{
  String id;
  String fullName;

  PostWritePage(this.id, this.fullName);

  @override
  State<StatefulWidget> createState() => _PostWritePage(id, fullName);
}

class _PostWritePage extends State<StatefulWidget>{
  String id;
  String fullName;
  _PostWritePage(this.id, this.fullName);

  TextEditingController? contentController;
  TextEditingController? titleController;

  void submitCard (String content, String type, String title) async{
    await db.collection("posts").add({'fullName' : fullName, 'type' : type, 'user' : id, 'time' :Timestamp.fromDate(DateTime.now()), 'content' : content, 'like' : 0, 'comment' : 0, 'title' : title}).then((DocumentReference doc) =>
    print('DocumentSnapshot added with ID: ${doc.id}'));
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    contentController = TextEditingController();
    titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), color: mColor1, onPressed: () { Navigator.of(context).pop(); },),
        centerTitle: true,
        elevation: 0,
        title: Text("Add Card", style: TextStyle(color: mColor1, fontFamily: 'Pacifico'),),
        actions: [
          IconButton(icon: Icon(Icons.save), color: mColor1, onPressed: () { submitCard(contentController!.value.text, 'Formal', titleController!.value.text); },),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Title*",
                    hintStyle: TextStyle(fontSize: 20.0,fontFamily: 'SCDream'),
                  ),
                  style: TextStyle(fontSize: 20.0,fontFamily: 'SCDream'),
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: "Content",
                    hintStyle: TextStyle(fontSize: 20.0,fontFamily: 'SCDream'),
                  ),
                  style:  TextStyle(fontSize: 20.0,fontFamily: 'SCDream'),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}