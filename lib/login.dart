import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:playground/pageRouteAnimation.dart';
import 'createAccountPage.dart';
import 'firebase_options.dart';
import 'mainPage.dart';
import 'colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
  bool _rememberMe = false;
  String? authCheck;
  TextEditingController? idController;
  TextEditingController? pwController;
  static final storage = new FlutterSecureStorage();

  void _firebaseSetting() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

  }

  @override
  void initState(){
    super.initState();
    authCheck = "";
    idController = TextEditingController();
    pwController = TextEditingController();
    _firebaseSetting();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    var userInfo = await storage.read(key: "login");

    //user의 정보가 있다면 바로 main 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      Navigator.of(context).pushReplacement(fadeRoute(MainPage(userInfo.split(",")[1],userInfo.split(",")[3]), 200));

    }
  }

  _fieldDecoration(String hintTxt){
    return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10, 4, 0, 0),
      fillColor: Color.fromRGBO(0, 0, 0, 0.050980392156862744),
      filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide:
      BorderSide(width: 1, color: Colors.transparent), //<-- SEE HERE
      borderRadius: BorderRadius.circular(50.0),
      ),focusedBorder: OutlineInputBorder(
      borderSide:
      BorderSide(width: 1, color: mColor1), //<-- SEE HERE
      borderRadius: BorderRadius.circular(50.0),
    ),
      hintText: hintTxt,
      hintStyle: TextStyle(fontSize: 20.0, color: Color.fromRGBO(0, 0, 0, 0.10980392156862744),fontFamily: 'SCDream'),
    );
  }

  void auth(String id, String pw) async{
    String? userName;
    bool isAuth = false;

    await db.collection("users").get().then((event) {
      cardDataList = List.empty(growable: true);
      for (var doc in event.docs) {
        var data = doc.data();
        if((data['id'] == id) && (data['pw'] == pw)){
          isAuth = true;
          userName = data['fullname'];
        }
      }
    });

    if(isAuth && _rememberMe){
      await storage.write(key: "login", value: "id," + id + ",fullname," + userName!);
      Navigator.of(context).pushReplacement(fadeRoute(MainPage(id, userName!),200));  //to do
    }else if(isAuth){
      Navigator.of(context).pushReplacement(fadeRoute(MainPage(id, userName!),200));
    }else{
      setState(() {
        authCheck = "Please check your ID or Password";
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Play",style: TextStyle(fontFamily: 'Pacifico',fontSize: 35,color: mColor1)),
                Text("Ground.com", style: TextStyle(fontFamily: 'Pacifico',fontSize: 35,color: mColor2))
              ],
            ),
            SizedBox(height: 20,),
            Container(
              width: 300,
              child: Text(authCheck!, textAlign: TextAlign.center, style: TextStyle(color: mColor1, fontFamily: 'SCDream'),),
              height: 30,
            ),
            Container(
              width: 300,
              child: TextField(textAlignVertical: TextAlignVertical.center, controller: idController,decoration: _fieldDecoration("ID or Email Address"),style: TextStyle(fontSize: 17,color: Colors.black38,fontFamily: 'SCDream'),),
              height: 40,
            ),
            SizedBox(height: 10,),
            Container(
                width: 300,
                child: TextField(textAlignVertical: TextAlignVertical.center, controller: pwController,decoration: _fieldDecoration("Password"),style: TextStyle(fontSize: 17,color: Colors.black38,fontFamily: 'SCDream'),obscureText: true,),
              height: 40,
            ),
            Container(
              width: 300,
              height: 40,
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      activeColor: mColor1,
                      checkColor: Colors.white,
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                      side: BorderSide(
                        color: Colors.black26,
                        width: 2,
                      ),
                    ),
                  ),
                  Text("Remember Me", style: TextStyle(fontSize: 15,fontFamily: 'SCDream',color: Colors.black45),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  auth(idController!.value.text, pwController!.value.text);
                },
                child: const Text('Login', style: TextStyle(fontSize: 15,fontFamily: 'SCDream',color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  primary: mColor1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(300,40),
                  maximumSize: Size(300,40),
                ),
              ),
            ),

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Doesn't have an account? ",style: TextStyle(color: Colors.black45,fontFamily: 'SCDream'),),
                InkWell(child:Text("Sign up",style: TextStyle(color: mColor2,fontFamily: 'SCDream'),),onTap: (){Navigator.push(context, fadeRoute((CreateAccountPage()), 200));}),
              ],
            )
          ],
        ),
      )
    );
  }
}