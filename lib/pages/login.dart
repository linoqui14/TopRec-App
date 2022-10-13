import 'dart:io';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hive/hive.dart';
import 'package:toprec/tools/variables.dart';

import '../custom_widgets/custom_text_field.dart';
import '../models/user.dart';
import 'home.dart';
class Login extends StatefulWidget {
  const Login({Key? key,}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLogin = true;

  @override
  void initState() {
    BoxCollection.open(
      'db.db', // Name of your database
      {'users',}, // Names of your boxes
      path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
    ).then((res) {
      final users = res.openBox<Map>('users');
      users.then((user) {

        user.get('currently-login').then((result) {
          if(result!=null){
            User user = User.toObject(result!);
            username.text = user.username;
            password.text = user.password;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home(user: user,)),
                  (Route<dynamic> route) => false,
            );
          }
          else{
            setState(() {
              isLogin = false;
            });
          }



        });

      });

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // print(Directory.current.path);
    return isLogin? Container(color: Color(0xff213A48),child: Center(child: CircularProgressIndicator(),)):
     Scaffold(
       appBar: AppBar(
         backgroundColor:Color(0xff213A48),
         elevation: 0,
         title:  Text("TOPREC",style: TextStyle(fontFamily: 'Tually',color: Colors.white,fontSize: MediaQuery.of(context).size.width*.02),),
         actions: [
           if(true)
             Container(
               padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
               child: Row(
                 children: [
                   TextButton(
                     onPressed: (){

                     },
                     child: Text("Contact",style: TextStyle(color: Colors.white),),
                   ),
                   Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                   TextButton(
                     onPressed: (){

                     },
                     child: Text("About",style: TextStyle(color: Colors.white),),
                   ),
                   Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                   if(false)//if login page
                     TextButton(
                       style: ButtonStyle(
                           fixedSize: MaterialStateProperty.all(Size(80, 30)),
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(20)),
                                 // side: BorderSide(color: Colors.red)
                               )
                           ),
                           backgroundColor: MaterialStateProperty.all(Color(0xff031620))
                       ),
                       onPressed: (){

                       },
                       child: Text("Logout",style: TextStyle(color: Colors.white),),
                     ),

                 ],
               ),
             ),
         ],

       ),
      body: Container(
        color: Color(0xff213A48),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [

              Opacity(
                opacity: 1,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_arirrjzh.json',width:  MediaQuery.of(context).size.width*.3,fit: BoxFit.fitWidth),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Padding(padding: EdgeInsets.symmetric(vertical: 70)),
                  Container(

                    margin: EdgeInsets.only(right: 50),
                    alignment: Alignment.centerRight,
                    child: AnimatedOpacity(
                        opacity: isLogin?0:1,
                        duration: Duration(milliseconds: 500),
                      child: Column(
                        children: [

                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Color(0xff3F5560).withAlpha(200),
                                border: Border.all(
                                  width: 3,
                                  color: Color(0xff839198),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            width: 400,
                            height: 350,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Login",style: TextStyle(fontFamily: 'Tually',color: Colors.white,fontSize: MediaQuery.of(context).size.width*.05),),
                                Column(
                                  children: [
                                    CustomTextField(
                                      color: Colors.white,
                                      hint: "Username",
                                      controller: username,
                                      radiusAll: 20,
                                    ),
                                    CustomTextField(
                                      obscureText: true,
                                      color: Colors.white,
                                      hint: "Password",
                                      controller: password,
                                      radiusAll: 20,
                                    )
                                  ],
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                                Builder(
                                    builder: (context) {
                                      bool isHover = true;
                                      return StatefulBuilder(
                                          builder: (context,setStateBTN) {

                                            return TextButton(
                                              onHover: (value){
                                                setStateBTN((){
                                                  isHover = value?false:true;
                                                });

                                              },
                                              style: ButtonStyle(
                                                  fixedSize: MaterialStateProperty.all(Size(80, 30)),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        // side: BorderSide(color: Colors.red)
                                                      )
                                                  ),
                                                  backgroundColor: MaterialStateProperty.all(!isHover?Colors.indigo:Color(0xff031620))
                                              ),
                                              onPressed: (){
                                                // // var user =  User(username: '201510${Random().nextInt(9000).toString()}',password: '123123',type: UserType.STUDENT);
                                                // //  DBController.createUser(user: user).then((value) {
                                                // //    print(value);
                                                // //  });
                                                //  var user =  User(username: 'faculty',password: '123123',type: UserType.FACULTY);
                                                //  DBController.createUser(user: user).then((value) {
                                                //    print(value);
                                                //  });
                                                if(password.text.isNotEmpty&&username.text.isNotEmpty){
                                                  DBController.getUser(username: username.text, password: password.text).then((value){
                                                    if(value!=null){
                                                      BoxCollection.open(
                                                        'db.db', // Name of your database
                                                        {'users',}, // Names of your boxes
                                                        path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
                                                      ).then((res) {
                                                        final users = res.openBox<Map>('users');
                                                        users.then((user) {
                                                          user.put('currently-login',value.toMap());
                                                          user.get('currently-login').then((result) {
                                                            if(result!=null){
                                                              User userR = User.toObject(result!);
                                                              Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => Home(user: userR,)),
                                                                    (Route<dynamic> route) => false,
                                                              );
                                                            }

                                                          });
                                                        });

                                                      });
                                                    }
                                                  });
                                                }
                                              },
                                              child: Text("Login",style: TextStyle(color: Colors.white),),
                                            );
                                          }
                                      );
                                    }
                                ),
                              ],
                            ),

                          ),
                        ],
                      ),

                    ),
                  )

                  // SvgPicture.asset(
                  //
                  //     color: Colors.white,
                  //     semanticsLabel: 'Toprec Logo',
                  //     width:MediaQuery.of(context).size.width*.2,
                  //     'img/logo.svg'
                  // )
                ],
              ),
              Container(
                padding: EdgeInsets.all(30),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Be your partner\nin building the topic of your",style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 70),),
                    Container(
                      margin: EdgeInsets.only(left: 0),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText("Thesis studies",textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 75,fontFamily: "Uni Sans") ,speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                          TypewriterAnimatedText("Group project",textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 75,fontFamily: "Uni Sans"),speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                          TypewriterAnimatedText("Personal project",textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 75,fontFamily: "Uni Sans"),speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                          TypewriterAnimatedText("Innovative ideas",textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 75,fontFamily: "Uni Sans"),speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}