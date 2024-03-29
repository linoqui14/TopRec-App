
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:toprec/custom_widgets/custom_toggle_buttons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:toprec/pages/faculty_home.dart';
import 'package:toprec/pages/login.dart';
import 'package:toprec/pages/result.dart';
import 'package:toprec/tools/variables.dart';
import '../custom_widgets/custom_text_button.dart';
import '../custom_widgets/custom_text_field.dart';
import '../models/user.dart';
import 'appbar.dart';

class Home extends StatefulWidget{
  const Home({Key? key,required this.user}) : super(key: key);
  final User user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  TextEditingController searchController = TextEditingController();
  List<String> selectedCategories = [];
  List<String> categories = [];
  late void Function(void Function()) _stateTitle;
  @override
  void initState() {
    DBController.getUser(username: widget.user.username, password: widget.user.password).then((value){
      // print(value!.recentSearch);
      if(value!.recentSearch.isNotEmpty&&value!=null){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Result(user: value,word: value.recentSearch,listOfCat: selectedCategories,)),
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
      appBar:header(widget.user,context,"home"),
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
                      SelectableText("Search for",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,fontSize: 50,fontFamily: "Uni Sans"),),
                      StatefulBuilder(
                          builder: (context,stateTitle) {
                            _stateTitle = stateTitle;
                            return Container(
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
                            );
                          }
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

                                    _stateTitle(() {

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
                                onPressed:(){
                                  String word = searchController.text;
                                  widget.user.recentSearch = word;
                                  DBController.updateUser(user:widget.user ).then((value) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => Result(user: widget.user,word: word,listOfCat: selectedCategories,)),
                                          (Route<dynamic> route) => false,
                                    );
                                    // print(value);
                                  });

                                },
                                color:MyColors.secondary,

                                text: "Go",
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width*.20,
                            height: MediaQuery.of(context).size.height*.8,
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
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: MyColors.darkPrimary,
                                      border: Border.all(
                                        width: 0,
                                        color: MyColors.secondary,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  child: SelectableText("Technology Categories",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                Padding(padding: EdgeInsets.all(10)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: FutureBuilder<String?>(
                                      future: DBController.post(command: "get_categories", parameters: {}),
                                      builder: (context,snapshot) {
                                        if(!snapshot.hasData)return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                        if(snapshot.connectionState==ConnectionState.waiting) {
                                          return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                        }

                                        var jsons = jsonDecode(snapshot.data!);
                                        for(String json in jsons['categories']){
                                          if(!categories.contains(json.toTitleCase())){
                                            categories.add(json.toTitleCase());
                                          }

                                        }
                                        categories.sort((a, b) {
                                          return a.toLowerCase().compareTo(b.toLowerCase());
                                        });
                                        TextEditingController searchCatCont = TextEditingController();
                                        return StatefulBuilder(
                                            builder: (context,stateSearchCat) {
                                              List<String> searchCats = [];
                                              for(String cat in categories){
                                                if(cat.toLowerCase().contains(searchCatCont.text.toLowerCase())){
                                                  searchCats.add(cat);
                                                }
                                              }
                                              return Column(

                                                children: [
                                                  CustomTextField(
                                                    radiusAll: 20,
                                                    color: Colors.white,
                                                    onChange: (value){
                                                      stateSearchCat((){

                                                      });
                                                    },
                                                    hint: 'Search Category...',
                                                    controller: searchCatCont,
                                                  ),
                                                  CustomToggleButtons(
                                                      value: selectedCategories,
                                                      onChange: (values){
                                                        setState(() {
                                                          selectedCategories = values;
                                                        });
                                                      },
                                                      height: MediaQuery.of(context).size.height*.55,
                                                      names: searchCatCont.text.isNotEmpty?searchCats:categories
                                                  ),
                                                ],
                                              );
                                            }
                                        );
                                      }
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