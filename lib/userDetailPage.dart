import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'colors.dart';
import 'detailPage.dart';
import 'pageRouteAnimation.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
bool _onloading = true;

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class UserDetailPage extends StatefulWidget{
  String? userId;
  String fullName;
  @override
  State<StatefulWidget> createState() => _UserDetailPage(userId!, fullName);

  UserDetailPage(this.userId, this.fullName);
}

class _UserDetailPage extends State<StatefulWidget>{
  List<Map> userCardDataList = List.empty(growable: true);

  @override
  void initState(){
    super.initState();
    _onloading = true;
    _getData(userId);
  }

  String userId;
  String fullName;

  _UserDetailPage(this.userId, this.fullName);

  Widget getCard(Map data) {
    return Card(
        shape: RoundedRectangleBorder(
        ),
        child: Column(
          children: [
            InkWell(
              onTap: (){
              },
              child: Row(
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
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(fadeRoute(DetailPage(data),200));
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    Text(data['title'], style: TextStyle(fontSize: 20, fontFamily: 'SCDream', fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1,textAlign: TextAlign.start,),
                    SizedBox(height: 10,),
                    Text(data['content'], style: TextStyle(fontSize: 17, fontFamily: 'SCDream'), overflow: TextOverflow.ellipsis, maxLines: 3,textAlign: TextAlign.start,),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(12,0,0,20),
              child: Row(
                children: [
                  IconButton(icon : Icon(Icons.favorite_border), onPressed: (){
                    setState(() {
                    });
                  },splashRadius: 15,),
                  SizedBox(width: 3,),
                  Text(data['like'].toString(), style: TextStyle(fontFamily: 'SCDream', fontSize: 15),),
                  SizedBox(width: 30,),
                  IconButton(icon: Icon(Icons.messenger_outline_rounded), onPressed: () {  }, splashRadius: 15,),
                  SizedBox(width: 3,),
                  Text(data['comment'].toString(), style: TextStyle(fontFamily: 'SCDream', fontSize: 15),),
                ],
              ),
            )
          ],
        )
    );
  }

  void _getData(String uId) async{
    await db.collection("posts").where("user",isEqualTo: uId).orderBy("time", descending: true).get().then((event) {
      userCardDataList = List.empty(growable: true);
      for (var doc in event.docs) {
        var data = doc.data();
        userCardDataList.add({'fullName' : data['fullName'], 'type' : data['type'], 'userId' : data['user'], 'cardId' : doc.id, 'time' : DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000), 'content' : data['content'], 'image' : 'image/1.png', 'like' : data['like'], 'comment' : data['comment'], 'title' : data['title'] ?? '제목 없음'});
      }
      setState(() {
        _onloading = false;
      });
    });
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
                      image: DecorationImage(image: AssetImage('image/1.png'),fit: BoxFit.cover)), //임시 코드
                  ),
                  SizedBox(height: 20,),
                  Text(fullName!, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),),
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
          SliverList(delegate: SliverChildListDelegate(List.generate(userCardDataList.length, (idx) => getCard(userCardDataList[idx])))),
        ],
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}