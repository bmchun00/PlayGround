import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playground/mainPage.dart';
import 'colors.dart';



class PostWritePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PostWritePage();
}

class _PostWritePage extends State<StatefulWidget>{
  TextEditingController? contentController;

  void submitCard (String content, String userId, String type) async{
    await db.collection("posts").add({'fullName' : 'Anonymous User', 'type' : 'Formal', 'user' : 'anonymous', 'time' :Timestamp.fromDate(DateTime.now()), 'content' : content, 'like' : 0, 'comment' : 0}).then((DocumentReference doc) =>
    print('DocumentSnapshot added with ID: ${doc.id}'));
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), color: mColor1, onPressed: () { Navigator.of(context).pop(); },),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Add Card (temp)", style: TextStyle(color: mColor1, fontFamily: 'Pacifico'),),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: contentController,
              ),
              ElevatedButton(onPressed: () => submitCard(contentController!.value.text, 'anonymous', 'Formal'), child: Text("Submit")),
            ],
          ),
        ),
      ),

    );
  }
}