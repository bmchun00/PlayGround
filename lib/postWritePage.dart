
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playground/mainPage.dart';
import 'colors.dart';
import 'dart:io';



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

  final ImagePicker _picker = ImagePicker();
  List<XFile> pickedImgs = [];

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
      case 3:
        return pickedImgs.length <= 4 ? Container() : FittedBox(
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                shape: BoxShape.circle
            ),
            child: Text(
              '+${(pickedImgs.length-4).toString()}',
            ),
          ),
        );
      default:
        return Container();
    }
  }
  

  Future<void> pickImage() async{
    final List<XFile>? imgs = await _picker.pickMultiImage();
    if(imgs != null){
      setState(() {
        pickedImgs = imgs;
      });
    }
  }



  void submitCard (String content, String type, String title) async{
    await db.collection("posts").add({'fullName' : fullName, 'type' : type, 'user' : id, 'time' :Timestamp.fromDate(DateTime.now()), 'content' : content, 'like' : 0, 'comment' : 0, 'title' : title}).then((DocumentReference doc) =>
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
                SizedBox(height: 10,),
                SizedBox(
                  height: 350,
                  child: GridView.count(
                      crossAxisCount: 2,
                    padding: EdgeInsets.all(2),
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    children: List.generate(4, (index) => DottedBorder(
                      child: Container(
                        child: Center(
                          child: getBoxContents(index),
                        ),
                        decoration: index <= pickedImgs.length -1
                        ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(pickedImgs[index].path).image,
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