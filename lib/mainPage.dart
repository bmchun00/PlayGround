import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:playground/myPage.dart';
import 'package:playground/postWritePage.dart';
import 'package:playground/splash.dart';
import 'package:intl/intl.dart';
import 'package:playground/userDetailPage.dart';
import 'detailPage.dart';

Route _createRoute(StatefulWidget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      }
  );
}

List<Widget> cList = new List.empty(growable: true);
Map cardDataDummyType1 = {'fullName' : 'Bmc Adaptive', 'type' : 1, 'userId' : 'BMC', 'cardId' : 1, 'time' : DateTime.parse('2023-03-29 20:18:04Z'), 'context' : 'Hello, Im BMC. I enjoy eating salmon and eating good food. I want to go to school, but I cant because Im stuck. Milkis zero is super delicious. Thank you.', 'image' : 'image/1.jpg'};
Map cardDataDummyType2 = {'fullName' : 'Lisa soo', 'type' : 2, 'userId' : 'Lss09', 'cardId' : 2, 'time' : DateTime.parse('2023-03-28 10:28:04Z'), 'context' : 'developed by a Brazilian programmer and based on Semantle, challenges players to decipher the mysterious word of the day. Its a game on the web that', 'image' : 'image/2.jpg'};
Map cardDataDummyType3 = {'fullName' : 'Joosu Park', 'type' : 3, 'userId' : 'jks2023', 'cardId' : 3, 'time' : DateTime.parse('2023-03-27 20:18:04Z'), 'context' : 'Thanos is a supervillain appearing in American comic books published by Marvel Comics. Created by writer-artist Jim Starlin, the character first appeared in The Invincible Iron Man', 'image' : 'image/3.jpg'};
List<Map> cardDataList = List.empty(growable: true);

Widget PageBuilder(int index){
  switch(index){
    case 0:
      return Scaffold(
        appBar:AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(mainAxisAlignment:MainAxisAlignment.center, children: [Text("Play", style: TextStyle(color: mColor1, fontFamily: 'Pacifico'),),Text("Ground", style: TextStyle(color: mColor2, fontFamily: 'Pacifico'),),],),
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(5),
            itemCount: cList.length,
            itemBuilder: (BuildContext context, int index){
              return cList[index];
            })
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
      return MyPage();
    default:
      return Scaffold(
        body: Text("This is Error Page"),
      );
  }
}

class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> with TickerProviderStateMixin{
  String typeToString(int type){
    switch(type){
      case 1:
        return 'Formal';
      case 2:
        return 'Type 2';
      case 3:
        return 'Something..';
      default:
        return 'bluh';
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDetailPage(data['userId']!)));
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
                      Text(data['fullName'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(typeToString(data['type']), style: TextStyle(fontSize: 10),),
                          Text(' | ', style: TextStyle(fontSize: 10),),
                          Text(data['userId'], style: TextStyle(fontSize: 10),),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(data['cardId'])));
              },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMd().add_jm().format(data['time']), style: TextStyle(fontSize: 10),),
                    SizedBox(height: 10,),
                    Text(data['context'], style: TextStyle(fontSize: 20),),
                    SizedBox(height: 15, ),
                    Row(
                      children: [
                        IconButton(icon : Icon(Icons.favorite_border), onPressed: (){
                          print("heart");
                          setState(() {
                          });
                        },splashRadius: 15,),
                        SizedBox(width: 10,),
                        Text("73"),
                        SizedBox(width: 30,),
                        IconButton(icon: Icon(Icons.messenger_outline_rounded), onPressed: () {  }, splashRadius: 15,),
                        SizedBox(width: 10,),
                        Text("1"),
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

  Widget getDemoCard(){
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(height: 100,width: 100, decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    image: const DecorationImage(image: AssetImage('image/2.jpg'),fit: BoxFit.cover)),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bmc adaptive", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("Tech Something | BMC",style: TextStyle(fontSize: 10),)
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jan 15, 2023 at 20:49 pm", style: TextStyle(fontSize: 10),),
                  SizedBox(height: 10,),
                  Text("Hello, I'm BMC. I enjoy eating salmon and eating good food. I want to go to school, but I can't because I'm stuck.", style: TextStyle(fontSize: 20),),
                  SizedBox(height: 15, ),
                  Row(
                    children: [
                      IconButton(icon : Icon(Icons.favorite), onPressed: (){
                        print("heart");
                        setState(() {
                        });
                      },splashRadius: 15,),
                      SizedBox(width: 10,),
                      Text("73"),
                      SizedBox(width: 30,),
                      IconButton(icon: Icon(Icons.messenger_outline_rounded), onPressed: () {  }, splashRadius: 15,),
                      SizedBox(width: 10,),
                      Text("1"),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
    );
  }

  TabController? controller;
  int _currentIndex = 0;

  @override
  void initState(){
    cardDataList.add(cardDataDummyType1);
    cardDataList.add(cardDataDummyType2);
    cardDataList.add(cardDataDummyType3);
    cardDataList.add(cardDataDummyType1);
    cardDataList.add(cardDataDummyType2);
    cList.add(getCard(cardDataList[0]));
    cList.add(getCard(cardDataList[1]));
    cList.add(getCard(cardDataList[2]));
    cList.add(getCard(cardDataList[3]));
    cList.add(getCard(cardDataList[4]));
    super.initState();
    controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
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
          Navigator.of(context).push(_createRoute(PostWritePage())); //nav 효과 추가 예정
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