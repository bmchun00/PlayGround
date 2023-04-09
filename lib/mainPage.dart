import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:playground/pageRouteAnimation.dart';
import 'package:playground/postWritePage.dart';
import 'package:intl/intl.dart';
import 'package:playground/userDetailPage.dart';
import 'detailPage.dart';
import 'colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

List<Map> cardDataList = List.empty(growable: true);
FirebaseFirestore db = FirebaseFirestore.instance;


class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MainPage extends StatefulWidget{
  String id;
  String fullName;
  MainPage(this.id, this.fullName);

  @override
  State<MainPage> createState() => _MainPage(id, fullName);
}

class _MainPage extends State<MainPage> with TickerProviderStateMixin{
  final storage = new FlutterSecureStorage();

  Widget MyPage(){
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page.."),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("LOGOUT"),
          onPressed: () async{
            storage.deleteAll();
            Navigator.of(context).pushReplacement(fadeRoute(LoginPage(), 200));
          },
        ),
      ),
    );
  }

  bool _onLoading = true;
  String id;
  String fullName;

  _MainPage(this.id, this.fullName);

  Widget PageBuilder(int index){
    switch(index){
      case 0: //main main
        return Scaffold(
          body: _onLoading? Center(child:CupertinoActivityIndicator(radius: 20,)) : CustomScrollView(
              scrollBehavior: NoGlow(),
              slivers: [
              SliverAppBar(
              toolbarHeight: 50.0,
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Row(mainAxisAlignment:MainAxisAlignment.center, children: [Text("Play", style: TextStyle(color: mColor1, fontFamily: 'Pacifico'),),Text("Ground", style: TextStyle(color: mColor2, fontFamily: 'Pacifico'),),],),
              floating: true,
              centerTitle: true,
              ),
              SliverList(delegate: SliverChildListDelegate(List.generate(cardDataList!.length, (idx) => getCard(cardDataList![idx]))))
            ],
            physics: BouncingScrollPhysics(),
          ),
        );
      case 1:
        return Scaffold(
          body: Text("This is My Page 1"),
        );
      case 2:
        return Scaffold(
          body: Text("This is My Page 2"),
        );
      case 3:
        return Scaffold(
          body: Text("This is My Page 3"),
        );
      case 4:
        return this.MyPage();
      default:
        return Scaffold(
          body: Text("This is Error Page"),
        );
    }
  }
  
  Widget getCard(Map data){
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.of(context).push(fadeRoute(UserDetailPage(data['userId']!), 200));
              },
              child: Row(
                children: [
                  Container(height: 100,width: 100, decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      image: DecorationImage(image: AssetImage(data['image']),fit: BoxFit.cover)),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['fullName'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data['type'], style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
                          Text(' | ', style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
                          Text(data['userId'], style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(fadeRoute(DetailPage(data['cardId']),200));
              },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMd().add_jm().format(data['time']), style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
                    SizedBox(height: 10,),
                    Text(data['content'], style: TextStyle(fontSize: 20, fontFamily: 'SCDream'),),
                    SizedBox(height: 15, ),
                    Row(
                      children: [
                        IconButton(icon : Icon(Icons.favorite_border), onPressed: (){
                          setState(() {
                          });
                        },splashRadius: 15,),
                        SizedBox(width: 10,),
                        Text(data['like'].toString()),
                        SizedBox(width: 30,),
                        IconButton(icon: Icon(Icons.messenger_outline_rounded), onPressed: () {  }, splashRadius: 15,),
                        SizedBox(width: 10,),
                        Text(data['comment'].toString()),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
  void getData() async{
    await db.collection("posts").orderBy("time", descending: true).get().then((event) {
      cardDataList = List.empty(growable: true);
      for (var doc in event.docs) {
        var data = doc.data();
        print(data);
        cardDataList.add({'fullName' : data['fullName'], 'type' : data['type'], 'userId' : data['user'], 'cardId' : doc.id, 'time' : DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000), 'content' : data['content'], 'image' : 'image/1.jpg', 'like' : data['like'], 'comment' : data['comment']});
      }
      setState(() {
        _onLoading = false;
      });
    });
  }


  int _currentIndex = 0;
  void firebaseSetting() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    setState(() {
      getData();
    });

  }

  @override
  void initState() {
    super.initState();
    firebaseSetting();
  }

  @override
  void dispose(){
    super.dispose();
  }
  _navigateAndDisplaySelection(BuildContext context) async {
    setState(() {
      _onLoading = true;
    });

    await Navigator.of(context).push(bottomUpRoute(PostWritePage(id,fullName)));
    setState(() {
      getData();
      _onLoading = false;
    });

  }

  Widget _buildFloatingBar() {
    return CustomNavigationBar(
      blurEffect: true,
      iconSize: 30.0,
      selectedColor: mColor1,
      strokeColor: mColor1,
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Icon(
            Icons.home
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.bar_chart_outlined
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.add_box_rounded
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.notifications_none_rounded
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_outlined
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        if(index==2){
          _navigateAndDisplaySelection(context);
        }
        else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
    );
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageBuilder(_currentIndex),
      bottomNavigationBar: _buildFloatingBar(),
    );
  }
}