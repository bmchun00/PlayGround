import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage>{
  int? _bottomNavIndex;
  List<IconData> iconList = [Icons.home,Icons.search,];

  @override
  void initState(){
    _bottomNavIndex =0;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex!,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }
}