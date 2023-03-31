import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:playground/myPage.dart';
import 'package:playground/pageRouteAnimation.dart';
import 'package:playground/postWritePage.dart';
import 'package:intl/intl.dart';
import 'package:playground/userDetailPage.dart';
import 'detailPage.dart';
import 'colors.dart';

Map cardDataDummyType1 = {'fullName' : 'Bmc Adaptive', 'type' : 1, 'userId' : 'BMC', 'cardId' : 1, 'time' : DateTime.parse('2023-03-29 20:18:04Z'), 'context' : 'Hello, Im BMC. I enjoy eating salmon and eating good food. I want to go to school, but I cant because Im stuck. Milkis zero is super delicious. Thank you.', 'image' : 'image/1.jpg'};
Map cardDataDummyType2 = {'fullName' : 'Lisa soo', 'type' : 2, 'userId' : 'Lss09', 'cardId' : 2, 'time' : DateTime.parse('2023-03-28 10:28:04Z'), 'context' : 'developed by a Brazilian programmer and based on Semantle, challenges players to decipher the mysterious word of the day. Its a game on the web that', 'image' : 'image/2.jpg'};
Map cardDataDummyType3 = {'fullName' : 'Joosu Park', 'type' : 3, 'userId' : 'jks2023', 'cardId' : 3, 'time' : DateTime.parse('2023-03-27 20:18:04Z'), 'context' : 'Thanos is a supervillain appearing in American comic books published by Marvel Comics. Created by writer-artist Jim Starlin, the character first appeared in The Invincible Iron Man', 'image' : 'image/3.jpg'};
List<Map> cardDataList = List.empty(growable: true);

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
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

  Widget PageBuilder(int index){
    switch(index){
      case 0: //main main
        return Scaffold(
          body: CustomScrollView(
              scrollBehavior: NoGlow(),
              slivers: [
              SliverAppBar(
              //SliverAppBar의 높이 설정
              toolbarHeight: 50.0,
              //SliverAppBar의 backgroundcolor
              backgroundColor: Colors.white,
              elevation: 0.0,
              //SliverAppBar title
              title: Row(mainAxisAlignment:MainAxisAlignment.center, children: [Text("Play", style: TextStyle(color: mColor1, fontFamily: 'Pacifico'),),Text("Ground", style: TextStyle(color: mColor2, fontFamily: 'Pacifico'),),],),
              //SliverAppBar 영역을 고정시킨다. default false
              pinned: false,
              // AppBar가 하단 List 내렸을 때 바로 보여야 한다 -> true
              // List를 최상단으로 올렸을 때만 나와야 한다. -> false
              floating: true,
              centerTitle: true,
              ),
              SliverList(delegate: SliverChildListDelegate(List.generate(cardDataList.length, (idx) => getCard(cardDataList[idx]))))
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
        return MyPage();
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
                          Text(typeToString(data['type']), style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
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
                    Text(data['context'], style: TextStyle(fontSize: 20, fontFamily: 'SCDream'),),
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

  int _currentIndex = 0;

  @override
  void initState(){
    cardDataList.add(cardDataDummyType1);
    cardDataList.add(cardDataDummyType2);
    cardDataList.add(cardDataDummyType3);
    cardDataList.add(cardDataDummyType1);
    cardDataList.add(cardDataDummyType2);
    super.initState();
  }

  @override
  void dispose(){
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
          Navigator.of(context).push(bottomUpRoute(PostWritePage())); //nav 효과 추가 예정
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