
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:toprec/custom_widgets/custom_toggle_buttons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:toprec/pages/login.dart';
import 'package:toprec/pages/result.dart';
import 'package:toprec/tools/variables.dart';
import '../custom_widgets/custom_text_button.dart';
import '../custom_widgets/custom_text_field.dart';
import '../models/user.dart';

class Home extends StatefulWidget{
  const Home({Key? key,required this.user}) : super(key: key);
  final User user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  TextEditingController searchController =TextEditingController();
  List<String> selectedCategories = [];


  @override
  void initState() {
    DBController.getUser(username: widget.user.username, password: widget.user.password).then((value){
     // print(value!.recentSearch);
      if(value!.recentSearch.isNotEmpty&&value!=null){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Result(user: value,word: value.recentSearch,)),
              (Route<dynamic> route) => false,
        );
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor:MyColors.primary,
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
                  if(true)//if login page
                    TextButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(80, 30)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                // side: BorderSide(color: Colors.red)
                              )
                          ),
                          backgroundColor: MaterialStateProperty.all(MyColors.secondary)
                      ),
                      onPressed: (){
                        BoxCollection.open(
                          'db.db', // Name of your database
                          {'users',}, // Names of your boxes
                          path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
                        ).then((res) {
                          final users = res.openBox<Map>('users');
                          users.then((user) {
                            user.clear();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                                  (Route<dynamic> route) => false,
                            );
                          });

                        });
                      },
                      child: Text("Logout",style: TextStyle(color: Colors.white),),
                    ),

                ],
              ),
            ),
        ],

      ),
      body: SafeArea(
        child: Container(
          color:MyColors.primary,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Search for",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,fontSize: 50,fontFamily: "Uni Sans"),),
                      Container(
                        margin: EdgeInsets.only(left: 55),
                        child: AnimatedTextKit(

                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText("Machine Learning",textAlign: TextAlign.center,textStyle:TextStyle(color: MyColors.secondary,fontWeight: FontWeight.w700,fontSize: 70,fontFamily: "Uni Sans") ,speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                            TypewriterAnimatedText("Artificial Intelligent",textAlign: TextAlign.center,textStyle:TextStyle(color: MyColors.secondary,fontWeight: FontWeight.w700,fontSize: 70,fontFamily: "Uni Sans"),speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                            TypewriterAnimatedText("Robot",textAlign: TextAlign.center,textStyle:TextStyle(color:MyColors.secondary,fontWeight: FontWeight.w700,fontSize: 70,fontFamily: "Uni Sans"),speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                            if(searchController.text.isNotEmpty)
                              TypewriterAnimatedText(searchController.text,textAlign: TextAlign.center,textStyle:TextStyle(color:MyColors.secondary,fontWeight: FontWeight.w700,fontSize: 70,fontFamily: "Uni Sans"),speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_arirrjzh.json',width:  MediaQuery.of(context).size.width*.5,fit: BoxFit.fitWidth),
                ),
                Container(
                  margin: EdgeInsets.only(top: 150),
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*.5,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  onChange: (value){
                                    setState(() {

                                    });
                                  },
                                  radiusAll: 20,
                                  fillColor:MyColors.darkPrimary,
                                  filled: true,
                                  icon: Icons.search,
                                  color: Colors.white,
                                  controller: searchController,
                                  hint: "Search here...",
                                ),
                              ),
                              CustomTextButton(
                                radiusAll: 50,
                                width: 50,
                                height: 46,
                                onPressed:(selectedCategories.isNotEmpty||searchController.text.isNotEmpty)? (){
                                  String word = searchController.text;
                                  for (var cat in selectedCategories) {
                                    word+=cat;
                                  }
                                  widget.user.recentSearch = word;
                                  DBController.updateUser(user:widget.user ).then((value) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => Result(user: widget.user,word: word,)),
                                          (Route<dynamic> route) => false,
                                    );
                                    // print(value);
                                  });
                                  // DBController.getRecommended(words: searchController.text).then((value) {
                                  //   print(value);
                                  // });
                                  // DBController.getSearch(words: searchController.text).then((value) {
                                  //   print(value);
                                  // });
                                }:null,
                                color: selectedCategories.length>0||searchController.text.isNotEmpty?MyColors.secondary:MyColors.darkPrimary.withAlpha(120),

                                text: "Go",
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width*.15,
                            height: MediaQuery.of(context).size.height*.5,
                            decoration: BoxDecoration(
                                color: MyColors.darkPrimary.withAlpha(200),
                                border: Border.all(
                                  width: 3,
                                  color: MyColors.secondary,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: MyColors.darkPrimary,
                                      border: Border.all(
                                        width: 0,
                                        color: MyColors.secondary,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  child: Text("Technology Categories",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                Padding(padding: EdgeInsets.all(10)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: CustomToggleButtons(
                                      onChange: (values){
                                        setState(() {
                                          selectedCategories = values;
                                        });
                                      },
                                      height: MediaQuery.of(context).size.height*.3,
                                      names: ['Internet of Things','Machine Learning','Artificial Intelegent(AI)','Natural Language Processing','Deep Learning','Big Data & Data Science','Block Chain Technology']
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                )


              ],
            ),
          ),
        ),
      ),

    );
  }

}