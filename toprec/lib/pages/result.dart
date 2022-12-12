import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:toprec/models/recommended_topic_result.dart';
import 'package:toprec/models/user.dart';
import 'package:toprec/pages/doc_page.dart';
import 'package:toprec/tools/variables.dart';
import 'package:flutter/services.dart';
import '../custom_widgets/custom_text_button.dart';
import '../custom_widgets/custom_text_field.dart';
import '../custom_widgets/custom_toggle_buttons.dart';
import '../models/search_result.dart';
import 'faculty_home.dart';
import 'login.dart';


class Result extends StatefulWidget {
  const Result({Key? key,required this.user,required this.word}) : super(key: key);
  final User user;
  final String word;
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  TextEditingController searchController =TextEditingController();
  List<String> selectedCategories = [];
  String word = "";
  @override
  void initState() {
    DBController.getUser(username: widget.user.username, password: widget.user.password).then((value) {
      setState(() {
        if(value==null)return;
        word = value.recentSearch;
        searchController.text = word;
      });
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
        title:  Row(
          children: [
            SelectableText("TOPREC   ",style: TextStyle(fontFamily: 'Tually',color: Colors.white,fontSize: MediaQuery.of(context).size.width*.02),),
            SelectableText(widget.user.type.toLowerCase())
          ],
        ),
        actions: [
          if(true)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              child: Row(
                children: [
                  TextButton(
                    onPressed: (){

                    },
                    child: SelectableText("Contact",style: TextStyle(color: Colors.white),),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                  TextButton(
                    onPressed: (){

                    },
                    child: SelectableText("About",style: TextStyle(color: Colors.white),),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                  if(widget.user.type.toUpperCase().compareTo(UserType.FACULTY.toUpperCase())==0)
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FacultyHome(user: widget.user)),

                        );
                      },
                      child: Text("Manage Theses",style: TextStyle(color: Colors.white),),
                    ),
                  if(widget.user.type.toUpperCase().compareTo(UserType.FACULTY.toUpperCase())==0)
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
          color: MyColors.primary,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomRight,
                  child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_arirrjzh.json',width:  MediaQuery.of(context).size.width*.5,fit: BoxFit.fitWidth),
                ),
                Container(
                  // margin: EdgeInsets.only(top: 150),
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*.8,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.5,
                            child: Row(
                              children: [
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*.4,
                                  child: CustomTextField(

                                    onEnter: (value){
                                      setState(() {
                                        word = "";
                                        word = searchController.text;
                                        for (var cat in selectedCategories) {
                                          word+=cat;
                                        }
                                        widget.user.recentSearch = word;
                                        DBController.updateUser(user:widget.user ).then((value) {
                                          setState(() {
                                            searchController.text = word;
                                          });

                                        });
                                      });
                                    },
                                    radiusAll: 20,
                                    fillColor: MyColors.darkPrimary,
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
                                    setState(() {
                                      word = "";
                                      word = searchController.text;
                                      for (var cat in selectedCategories) {
                                        word+=cat;
                                      }
                                      widget.user.recentSearch = word;
                                      DBController.updateUser(user:widget.user ).then((value) {
                                        setState(() {
                                          searchController.text = word;
                                        });

                                      });
                                    });
                                    // DBController.getRecommended(words: searchController.text).then((value) {
                                    //   print(value);
                                    // });
                                    // DBController.getSearch(words: searchController.text).then((value) {
                                    //   print(value);
                                    // });
                                  }:null,
                                  color: selectedCategories.length>0||searchController.text.isNotEmpty?MyColors.secondary:Color(0xff031620).withAlpha(120),

                                  text: "Go",
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                            List<String> categories = [];
                                            var jsons = jsonDecode(snapshot.data!);
                                            for(String json in jsons['categories']){
                                              categories.add(json.toTitleCase());
                                            }

                                            return CustomToggleButtons(
                                                onChange: (values){
                                                  // setState(() {
                                                  //   selectedCategories = values;
                                                  // });
                                                },
                                                height: MediaQuery.of(context).size.height*.70,
                                                names: categories
                                            );
                                          }
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  height: MediaQuery.of(context).size.height*.8,
                                  // height: MediaQuery.of(context).size.height*.5,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(100),
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
                                            borderRadius: BorderRadius.only(topRight:Radius.circular(18),topLeft: Radius.circular(18))
                                        ),
                                        child: SelectableText("Recommended Topic",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(padding: EdgeInsets.all(10)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: FutureBuilder<String?>(
                                          future: DBController.get(command: "generate_topic", parameters: {"words":searchController.text}),
                                          builder: (BuildContext context, snapshot)
                                          {
                                              if(!snapshot.hasData)return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                              if(snapshot.connectionState==ConnectionState.waiting) {
                                                return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                              }
                                              var jsons = jsonDecode(snapshot.data!);
                                              List<RecommendedTopic> recommendedTopics = [];
                                              print(jsons);
                                              for(var json in jsons){
                                                recommendedTopics.add(RecommendedTopic.toObject(json));
                                              }
                                              return SizedBox(
                                                height: MediaQuery.of(context).size.height*.70,
                                                child: ListView(
                                                  children: recommendedTopics.map((topic) {
                                                    return Container(
                                                        margin: EdgeInsets.only(bottom: 5),
                                                        width:double.infinity,
                                                        decoration: BoxDecoration(
                                                            color: MyColors.darkPrimary,

                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        padding: EdgeInsets.all(10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SelectableText(topic.topic.toTitleCase(),style: TextStyle(color:Colors.white),),
                                                            // SelectableText(re.AUTHOR.replaceAll("\n", ",")),
                                                            // SelectableText(re.YEAR.replaceAll("\n", "")+" "+re.MONTH.replaceAll("\n", ""),style: TextStyle(fontWeight: FontWeight.w100,fontSize: 10),)
                                                          ],
                                                        )
                                                    );
                                                    // return Container(
                                                    //   padding: EdgeInsets.all(10),
                                                    //     decoration: BoxDecoration(
                                                    //         color: MyColors.primary,
                                                    //         // border: Border.all(
                                                    //         //   width: 3,
                                                    //         //   color: MyColors.secondary,
                                                    //         // ),
                                                    //         borderRadius: recommendedTopics.indexOf(topic)==0? BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) ):recommendedTopics.indexOf(topic)==recommendedTopics.length-1?BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) ):BorderRadius.zero
                                                    //     ),
                                                    //     child: InkWell(
                                                    //         onTap: (){
                                                    //           Clipboard.setData(ClipboardData(text: topic.topic))
                                                    //               .then((value) { //only if ->
                                                    //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied to clipboard"))); // -> show a notification
                                                    //           });
                                                    //         },
                                                    //         child: SelectableText(topic.topic.toTitleCase(),style: TextStyle(color: Colors.white),)
                                                    //     )
                                                    // );
                                                  }).toList(),
                                                ),
                                              );
                                          },

                                        )
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: MediaQuery.of(context).size.height*.8,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color:Colors.white.withAlpha(100),
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
                                            borderRadius: BorderRadius.only(topRight:Radius.circular(18),topLeft: Radius.circular(18))
                                        ),
                                        child: SelectableText("Related Studies",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                      ),
                                      FutureBuilder<String?>(
                                          future: DBController.getSearch(words: word),
                                          builder:(context,snapshot){

                                            if(!snapshot.hasData)return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                            if(snapshot.connectionState==ConnectionState.waiting) {
                                              return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                            }
                                            // print(snapshot.data!);
                                            var jsonObject = jsonDecode(snapshot.data!);
                                            List<SearchResult> rResults = [];

                                            for(var jsObject in jsonObject){
                                              rResults.add(SearchResult.toObject(jsObject));
                                            }
                                            if(rResults.isEmpty) {
                                              return Container(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Lottie.network('https://assets3.lottiefiles.com/packages/lf20_wnqlfojb.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),
                                                    Padding(padding: EdgeInsets.only(bottom: 15)),
                                                    SelectableText("No Results for",style:TextStyle(color: MyColors.secondary,fontWeight: FontWeight.w100,fontSize: 15)),
                                                    SelectableText(word,style:TextStyle(color: MyColors.secondary,fontWeight: FontWeight.bold,fontSize: 25)),

                                                  ],
                                                ),
                                              );
                                            }

                                            return Container(

                                              height: MediaQuery.of(context).size.height*.70,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                child: ListView(
                                                  children: rResults.map((re) {
                                                    bool isHover = false;
                                                    return StatefulBuilder(
                                                      builder: (context,stateTitle) {
                                                        return InkWell(
                                                          onHover: (value){
                                                            print(value);
                                                            stateTitle((){
                                                              isHover = isHover?false:true;

                                                            });
                                                          },
                                                          child: Container(
                                                              // margin: EdgeInsets.all(5),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.transparent,
                                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                                              ),
                                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                      width:double.infinity,
                                                                      decoration: BoxDecoration(
                                                                          color: isHover?MyColors.secondary:MyColors.darkPrimary,

                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                                                                      ),
                                                                      padding: EdgeInsets.all(10),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          SelectableText(re.TITLE.replaceAll("\n", "").toTitleCase(),style: TextStyle(color:Colors.white),),
                                                                          // SelectableText(re.AUTHOR.replaceAll("\n", ",")),
                                                                          // SelectableText(re.YEAR.replaceAll("\n", "")+" "+re.MONTH.replaceAll("\n", ""),style: TextStyle(fontWeight: FontWeight.w100,fontSize: 10),)
                                                                        ],
                                                                      )
                                                                  ),
                                                                  CustomTextButton(
                                                                    rTl: 0,
                                                                    rTR: 0,
                                                                    color: MyColors.primary,
                                                                    onPressed: (){
                                                                      widget.user.currentSelected = re.TITLE;
                                                                      DBController.updateUser(user: widget.user).then((value) {
                                                                        Navigator.pushAndRemoveUntil(
                                                                          context,
                                                                          MaterialPageRoute(builder: (context) => DocumentPage(user: widget.user, searchResult: re)),
                                                                              (Route<dynamic> route) => true,
                                                                        );
                                                                      });
                                                                    },
                                                                    text: "More",
                                                                  ),
                                                                  // Container(
                                                                  //     padding: EdgeInsets.all(10),
                                                                  //     decoration: BoxDecoration(
                                                                  //         color: MyColors.darkPrimary,
                                                                  //         // border: Border.all(
                                                                  //         //   width: 3,
                                                                  //         //   // color: Color(0xff839198),
                                                                  //         // ),
                                                                  //         borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight: Radius.circular(0),bottomLeft: Radius.circular(20))
                                                                  //     ),
                                                                  //     child: SelectableText(re.ABTRACT.replaceAll("\n", ""),style: TextStyle(color: Colors.white),)
                                                                  // ),
                                                                  // Container(
                                                                  //     alignment:Alignment.centerRight,
                                                                  //     // padding: EdgeInsets.all(10),
                                                                  //     child: Container(
                                                                  //       alignment: Alignment.center,
                                                                  //       height: 50,
                                                                  //         width: 100,
                                                                  //         decoration: BoxDecoration(
                                                                  //             color: MyColors.primary,
                                                                  //
                                                                  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight:Radius.circular(0),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                                                                  //         ),
                                                                  //         child: SelectableText("More",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 20),)
                                                                  //     )
                                                                  // ),

                                                                ],
                                                              )
                                                          ),
                                                        );
                                                      }
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            );
                                          }
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
