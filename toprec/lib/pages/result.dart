import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:toprec/models/recommended_topic_result.dart';
import 'package:toprec/models/user.dart';
import 'package:toprec/pages/account.dart';
import 'package:toprec/pages/appbar.dart';
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
  const Result({Key? key,required this.user,required this.word,required this.listOfCat}) : super(key: key);
  final User user;
  final String word;
  final List<String> listOfCat;
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

    selectedCategories = widget.listOfCat;
    super.initState();
  }
  String catToString(String del){
    String catstring = "";
    for(String cat in selectedCategories){
      catstring+=cat+del;
    }
    return catstring;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: header(widget.user,context,"result"),
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
                                        word = searchController.text;
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
                                  onPressed:(selectedCategories.isNotEmpty||searchController.text.isNotEmpty)? (){
                                    // if(selectedCategories.isNotEmpty&&searchController.text.isNotEmpty){
                                    //   searchController.text = "";
                                    //   return;
                                    // }
                                    setState(() {
                                      word = searchController.text;
                                      widget.user.recentSearch = word;
                                      DBController.updateUser(user:widget.user ).then((value) {
                                        setState(() {
                                          searchController.text = word;
                                        });

                                      });
                                    });

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
                                          future: DBController.get(command: "generate_topic", parameters: {"words":searchController.text+" "+catToString(" ")}),
                                          builder: (BuildContext context, snapshot)
                                          {
                                              if(!snapshot.hasData)return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                              if(snapshot.connectionState==ConnectionState.waiting) {
                                                return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                              }
                                              var jsons = jsonDecode(snapshot.data!);
                                              List<RecommendedTopic> recommendedTopics = [];


                                              for(var json in jsons){
                                                recommendedTopics.add(RecommendedTopic.toObject(json));
                                              }
                                              recommendedTopics.sort((a, b) {
                                                return a.topic.toLowerCase().compareTo(b.topic.toLowerCase());
                                              });
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
                                          future: selectedCategories.isNotEmpty&&word.isEmpty?DBController.get(command: "get_all_thesis", parameters: {}):DBController.getSearch(words: word),
                                          builder:(context,snapshot){

                                            if(!snapshot.hasData)return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                            if(snapshot.connectionState==ConnectionState.waiting) {
                                              return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                            }

                                            var jsonObject = jsonDecode(snapshot.data!);
                                            List<SearchResult> rResults = [];

                                            for(var jsObject in jsonObject){
                                              SearchResult sResult = SearchResult.toObject(jsObject);
                                              if(rResults.where((element) => element.ID==sResult.ID).isNotEmpty)continue;
                                              if(selectedCategories.isNotEmpty){
                                                for(String cat in selectedCategories){
                                                  List<String> tCats = sResult.CATEGORY.split(",");
                                                  for(String tCat in tCats){
                                                    if(tCat.toLowerCase().contains(cat.toLowerCase())){
                                                      rResults.add(sResult);
                                                    }
                                                  }

                                                }
                                              }
                                              else{

                                                rResults.add(sResult);
                                              }



                                            }
                                            // print(catToString(","));
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
                                                            // print (value);
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
