import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playground/mainPage.dart';
import 'colors.dart';
import 'dart:html' as html;
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:io' as i;


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
  List<Uint8List> bytesFromPicker = [];


  TextEditingController? contentController;
  TextEditingController? titleController;
  
  Widget getBoxContents(int index){
    switch(index){
      case 0:
        return IconButton(onPressed: (){pickImage();}, icon: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.camera,
            color: Theme.of(context).colorScheme.primary,
          ),
        ));
      default:
        return Container();
    }
  }
  

  Future<void> pickImage() async{
    bytesFromPicker = await ImagePickerWeb.getMultiImagesAsBytes() ?? [];
    if(bytesFromPicker.length>=4){
      bytesFromPicker = bytesFromPicker.sublist(0,4);
    }
    setState(() {
    });
  }


  void submitCard (String content, String type, String title) async{
    List<String> base64ImgList = [];
    bytesFromPicker.forEach((item) async {
      base64ImgList.add(base64Encode(item));
    });

    await db.collection("posts").add({'imgCount' : bytesFromPicker.length, 'imgs' : base64ImgList, 'fullName' : fullName, 'type' : type, 'user' : id, 'time' :Timestamp.fromDate(DateTime.now()), 'content' : content, 'like' : 0, 'comment' : 0, 'title' : title}).then((DocumentReference doc) =>
    print('DocumentSnapshot added with ID: ${doc.id}'));
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
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
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0), child: IconButton(icon: Icon(Icons.save), color: mColor1, onPressed: () { submitCard(contentController!.value.text, 'Formal', titleController!.value.text); },),)
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: ListView(
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
                  keyboardType: TextInputType.multiline,
                  minLines: 10,
                  maxLines: null,
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: "Content",
                    hintStyle: TextStyle(fontSize: 20.0,fontFamily: 'SCDream'),
                  ),
                  style:  TextStyle(fontSize: 20.0,fontFamily: 'SCDream'),
                ),
                SizedBox(height: 15,),
                SizedBox(
                  child: GridView.count(
                    shrinkWrap: true,
                      crossAxisCount: 2,
                    padding: EdgeInsets.all(2),
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    children: List.generate(4, (index) => DottedBorder(
                      child: Container(
                        child: Center(
                          child: getBoxContents(index),
                        ),
                          decoration: index <= bytesFromPicker.length-1
                              ? BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.memory(bytesFromPicker[index]).image,
                              )
                          )
                              : null
                      ),
                      color: Colors.grey,
                      dashPattern: [5,4],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                    )).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}