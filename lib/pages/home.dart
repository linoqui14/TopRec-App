
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toprec/custom_widgets/custom_toggle_buttons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
      body: SafeArea(
        child: Container(
          color: Color(0xff213A48),
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
                            TypewriterAnimatedText("Machine Learning",textAlign: TextAlign.center,textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 70,fontFamily: "Uni Sans") ,speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                            TypewriterAnimatedText("Artificial Intelligent",textAlign: TextAlign.center,textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 70,fontFamily: "Uni Sans"),speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                            TypewriterAnimatedText("Robot",textAlign: TextAlign.center,textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 70,fontFamily: "Uni Sans"),speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
                            if(searchController.text.isNotEmpty)
                              TypewriterAnimatedText(searchController.text,textAlign: TextAlign.center,textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 70,fontFamily: "Uni Sans"),speed: Duration(milliseconds: 150),curve: Curves.easeInOutCubic),
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
                                  fillColor: Color(0xff22495F),
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
                                onPressed:(selectedCategories.length>0||searchController.text.isNotEmpty)? (){
                                  DBController.getRecommended(words: searchController.text).then((value) {
                                    print(value);
                                  });
                                  DBController.getSearch(words: searchController.text).then((value) {
                                    print(value);
                                  });
                                }:null,
                                color: selectedCategories.length>0||searchController.text.isNotEmpty?Colors.indigo:Color(0xff031620).withAlpha(120),

                                text: "Go",
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width*.2,
                            height: MediaQuery.of(context).size.height*.5,
                            decoration: BoxDecoration(
                                color: Color(0xff3F5560).withAlpha(200),
                                border: Border.all(
                                  width: 3,
                                  color: Color(0xff839198),
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
                                      color: Color(0xff22495F),
                                      border: Border.all(
                                        width: 0,
                                        color: Color(0xff839198),
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  child: Text("Technologies Categories",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
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
                          )

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