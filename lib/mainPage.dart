import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:playground/splash.dart';


class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage>{
  int _currentIndex = 0;

  Widget _buildFloatingBar() {
    return CustomNavigationBar(
      
      blurEffect: true,
      iconSize: 30.0,
      selectedColor: mColor1,
      strokeColor: mColor1,
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.white,
      borderRadius: Radius.circular(50.0),
      items: [
        CustomNavigationBarItem(
          icon: Icon(
            Icons.home
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.shopping_bag_outlined
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.account_balance
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.search
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            Icons.supervised_user_circle_outlined
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      isFloating: true,
    );
  }

  List<IconData> iconList = [Icons.home,Icons.search,];


  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: _buildFloatingBar(),
    );
  }
}