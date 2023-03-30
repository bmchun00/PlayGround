import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:playground/myPage.dart';
import 'package:playground/splash.dart';
List<Widget> cList = new List.empty(growable: true);


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
  Widget getDemoCard(){
    Color isLiked = Colors.grey;
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
                          isLiked = Colors.red;
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
    cList.add(getDemoCard());
    cList.add(getDemoCard());
    cList.add(getDemoCard());
    cList.add(getDemoCard());
    cList.add(getDemoCard());
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
            Icons.search
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.add_circle_outline_sharp
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
        setState(() {
          _currentIndex = index;
        });
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