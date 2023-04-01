import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';
import 'detailPage.dart';
import 'pageRouteAnimation.dart';


Map cardDataDummyType1 = {'fullName' : 'Bmc Adaptive', 'type' : 1, 'userId' : 'BMC', 'cardId' : 1, 'time' : DateTime.parse('2023-03-29 20:18:04Z'), 'context' : 'Hello, Im BMC. I enjoy eating salmon and eating good food. I want to go to school, but I cant because Im stuck. Milkis zero is super delicious. Thank you.', 'image' : 'image/1.jpg'};
Map cardDataDummyType2 = {'fullName' : 'Lisa soo', 'type' : 2, 'userId' : 'Lss09', 'cardId' : 2, 'time' : DateTime.parse('2023-03-28 10:28:04Z'), 'context' : 'developed by a Brazilian programmer and based on Semantle, challenges players to decipher the mysterious word of the day. Its a game on the web that', 'image' : 'image/2.jpg'};
Map cardDataDummyType3 = {'fullName' : 'Joosu Park', 'type' : 3, 'userId' : 'jks2023', 'cardId' : 3, 'time' : DateTime.parse('2023-03-27 20:18:04Z'), 'context' : 'Thanos is a supervillain appearing in American comic books published by Marvel Comics. Created by writer-artist Jim Starlin, the character first appeared in The Invincible Iron Man', 'image' : 'image/3.jpg'};


class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

int uIdTouIdNum(String uId){
  if(uId == 'BMC') return 0;
  else if(uId == 'Lss09') return 1;
  else return 2;
}

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

class UserDetailPage extends StatefulWidget{
  String? userId;
  @override
  State<StatefulWidget> createState() => _UserDetailPage(userId!);

  UserDetailPage(String uId){
    userId = uId;
  }
}

class _UserDetailPage extends State<StatefulWidget>{
  List<Map> userCardDataList = List.empty(growable: true);

  @override
  void initState(){
    super.initState();
    switch(userId){  //실제 상황에서는 바꿔야 하는 부분
      case 'BMC':
        userCardDataList.add(cardDataDummyType1);
        userCardDataList.add(cardDataDummyType1);
        userCardDataList.add(cardDataDummyType1);
        userCardDataList.add(cardDataDummyType1);
        userCardDataList.add(cardDataDummyType1);
        break;
      case 'Lss09':
        userCardDataList.add(cardDataDummyType2);
        userCardDataList.add(cardDataDummyType2);
        userCardDataList.add(cardDataDummyType2);
        userCardDataList.add(cardDataDummyType2);
        userCardDataList.add(cardDataDummyType2);
        break;
      default:
        userCardDataList.add(cardDataDummyType3);
        userCardDataList.add(cardDataDummyType3);
        userCardDataList.add(cardDataDummyType3);
        userCardDataList.add(cardDataDummyType3);
        userCardDataList.add(cardDataDummyType3);
        break;
    }
  }

  String? userId;

  _UserDetailPage(String uId){
    userId = uId;
  }

  Widget getCard(Map data) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
              },
              child: Row(
                children: [
                  Container(height: 100, width: 100, decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      image: DecorationImage(
                          image: AssetImage(data['image']), fit: BoxFit.cover)),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['fullName'], style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(typeToString(data['type']),
                            style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
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
              onTap: () {
                Navigator.of(context).push(
                    fadeRoute(DetailPage(data['cardId']), 200));
              },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMd().add_jm().format(data['time']),
                      style: TextStyle(fontSize: 10, fontFamily: 'SCDream'),),
                    SizedBox(height: 10,),
                    Text(data['context'], style: TextStyle(fontSize: 20, fontFamily: 'SCDream'),),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite_border), onPressed: () {
                          print("heart");
                          setState(() {});
                        }, splashRadius: 15,),
                        SizedBox(width: 10,),
                        Text("73"),
                        SizedBox(width: 30,),
                        IconButton(icon: Icon(Icons.messenger_outline_rounded),
                          onPressed: () {},
                          splashRadius: 15,),
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


  Widget build(BuildContext context){
    return Scaffold(
      body: CustomScrollView(
        scrollBehavior: NoGlow(),
        slivers: [
          SliverAppBar(
            //SliverAppBar의 높이 설정
            toolbarHeight: 50.0,
            //SliverAppBar의 backgroundcolor
            backgroundColor: Colors.white,
            expandedHeight: 400,
            elevation: 0.0,
            //SliverAppBar title
            title: Row(mainAxisSize: MainAxisSize.min,mainAxisAlignment:MainAxisAlignment.center, children: [Text("Play", style: TextStyle(color: mColor1, fontFamily: 'Pacifico'),),Text("Ground", style: TextStyle(color: mColor2, fontFamily: 'Pacifico'),),],),
            //SliverAppBar 영역을 고정시킨다. default false
            pinned: true,
            floating: false,
            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), color: mColor1, onPressed: () { Navigator.of(context).pop(); },),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 150,width: 150, decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(image: AssetImage(userCardDataList[uIdTouIdNum(userId!)]['image']),fit: BoxFit.cover)), //임시 코드
                  ),
                  SizedBox(height: 20,),
                  Text(userCardDataList[uIdTouIdNum(userId!)]['fullName'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),),
                  Container(
                    width: 50,
                    child: Divider(color: Colors.black, thickness: 0.3,),
                  ),
                  Text(userId!, style: TextStyle(fontSize: 17,color: Colors.black54, fontFamily: 'SCDream'),),
                  SizedBox(height: 20,),
                  Text("‘"+"Milkis zero is better than Milkis original."+"’", style: TextStyle(fontSize: 20,fontFamily: 'Jeju', fontStyle: FontStyle.italic ,color: Colors.black87),),
                ],
              ),
            ),
            snap: false,

          ),
          SliverList(delegate: SliverChildListDelegate(List.generate(userCardDataList.length, (idx) => getCard(userCardDataList[idx]))))
        ],
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}