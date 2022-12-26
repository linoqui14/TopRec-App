import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:toprec/pages/result.dart';

import '../custom_widgets/custom_text_button.dart';
import '../custom_widgets/custom_text_field.dart';
import '../custom_widgets/custom_toggle_buttons.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../tools/variables.dart';
import 'doc_page.dart';
import 'login.dart';

class FacultyHome extends StatefulWidget{
  const FacultyHome({Key? key,required this.user}) : super(key: key);
  final User user;
  @override
  State<FacultyHome> createState() => FacultyHomeState();
}

class FacultyHomeState extends State<FacultyHome>{
  TextEditingController searchController =TextEditingController();
  List<String> selectedCategories = [];
  List<SearchResult> searchResults= [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor:MyColors.primary,
        elevation: 0,
        title:  Row(
          children: [
            SelectableText("TOPREC  ",style: TextStyle(fontFamily: 'Tually',color: Colors.white,fontSize: MediaQuery.of(context).size.width*.02),),
            SelectableText(widget.user.type.toLowerCase())
          ],
        ),
        actions: [
          if(false)
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
                      child: SelectableText("Logout",style: TextStyle(color: Colors.white),),
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

                Opacity(
                  opacity: 0.3,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child:  Lottie.network('https://assets7.lottiefiles.com/packages/lf20_cwA7Cn.json',width:  MediaQuery.of(context).size.width*.5,fit: BoxFit.fitWidth),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding:EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width*.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText("Manage Theses",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "Uni Sans"),),
                          CustomTextButton(
                            color: MyColors.secondary,
                            onPressed: (){
                              // 'month':MONTH,
                              // 'year':YEAR,
                              // 'author':AUTHOR,
                              // 'adviser':ADVISER,
                              // 'title':TITLE,
                              // 'abstract':ABTRACT,
                              // 'recommendation':RECOMMENDATION,
                              // 'keywords':KEYWORDS,
                              // 'members':MEMBERS,
                              // 'category':CATEGORY,
                              // 'tags':TAGS,
                              TextEditingController title = TextEditingController();
                              TextEditingController author = TextEditingController();
                              TextEditingController adviser = TextEditingController();
                              TextEditingController abstract = TextEditingController();
                              TextEditingController recommendation = TextEditingController();
                              TextEditingController keywords = TextEditingController();
                              TextEditingController members = TextEditingController();
                              TextEditingController category = TextEditingController();
                              List<String> months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                              List<String> years = [];
                              for(int i = 1990;i <= DateTime.now().year;i++){
                                years.add(i.toString());
                              }
                              years.sort((a,b)=>a.compareTo(b));

                              String year =years.last;
                              String month = months.first;
                              Tools.basicDialog(context: context,
                                  statefulBuilder: StatefulBuilder(
                                      builder: (addThesisContext,setStateAddThesis){
                                        return Dialog(
                                          alignment: Alignment.center,
                                          backgroundColor: Colors.transparent,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                padding:EdgeInsets.all(10),
                                                width: MediaQuery.of(context).size.width*.7,
                                                height: MediaQuery.of(context).size.width*.35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 3,
                                                      color: MyColors.secondary,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    color: MyColors.darkPrimary
                                                ),
                                                child: Center(
                                                  child: ListView(
                                                    children: [
                                                      Text("Add Thesis",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "Uni Sans")),
                                                      Row(
                                                        children: [
                                                          Expanded(child: CustomTextField(hint: "Title", controller: title,color: Colors.white,)),
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              border:Border.all(
                                                                color: Colors.white,
                                                                width: 1
                                                              )
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                SizedBox(
                                                                  width:200,
                                                                  child: DropdownButton<String>(
                                                                    dropdownColor: MyColors.darkPrimary,
                                                                    icon: const Icon(Icons.arrow_downward),
                                                                    elevation: 16,
                                                                    underline: Container(
                                                                      height: 2,
                                                                      color: MyColors.secondary,
                                                                    ),
                                                                    hint: Text("Month"),
                                                                    value: month,
                                                                    onChanged: (value){
                                                                      setStateAddThesis((){
                                                                        month = value!;
                                                                      });
                                                                    },
                                                                    items: months.map<DropdownMenuItem<String>>((e) {
                                                                      return DropdownMenuItem(
                                                                          value: e,
                                                                          child: Text(e,style: TextStyle(color:Colors.white),)
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                ),
                                                                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                                                SizedBox(
                                                                  width:200,
                                                                  child: DropdownButton<String>(
                                                                    dropdownColor: MyColors.darkPrimary,
                                                                    icon: const Icon(Icons.arrow_downward),
                                                                    elevation: 16,
                                                                    underline: Container(
                                                                      height: 2,
                                                                      color: MyColors.secondary,
                                                                    ),
                                                                    hint: Text("Year"),
                                                                    value: year,
                                                                    onChanged: (value){
                                                                      setStateAddThesis((){
                                                                        year = value!;
                                                                      });
                                                                    },
                                                                    items: years.map<DropdownMenuItem<String>>((e) {
                                                                      return DropdownMenuItem(
                                                                          value: e,
                                                                          child: Text(e,style: TextStyle(color:Colors.white),)
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      CustomTextField(hint: "Abstract", controller: abstract,lines: 6,color: Colors.white),
                                                      CustomTextField(hint: "Author/s separated by comma", controller: author,lines: 1,color: Colors.white),
                                                      CustomTextField(hint: "Adviser/s separated by comma", controller: adviser,lines: 1,color: Colors.white),
                                                      // CustomTextField(hint: "Members", controller: members,lines: 1,color: Colors.white),
                                                      CustomTextField(hint: "Recommendation", controller: recommendation,lines:3,color: Colors.white),
                                                      CustomTextField(hint: "Keyword/s separated by comma", controller: keywords,lines: 1,color: Colors.white),
                                                      CustomTextField(hint: "Category", controller: category,lines: 1,color: Colors.white),



                                                    ],
                                                  )
                                                ),
                                              ),
                                              Padding(padding: EdgeInsets.only(bottom: 10)),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  CustomTextButton(
                                                    onPressed: (){
                                                      Navigator.of(context).pop();
                                                    },
                                                    color: Colors.red,
                                                    text: "Cancel",

                                                  ),
                                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                                  CustomTextButton(
                                                    onPressed: (){
                                                      SearchResult searchResult = SearchResult(
                                                          TITLE: title.text,
                                                          ABTRACT: abstract.text,
                                                          MEMBERS: members.text,
                                                          YEAR: year,
                                                          MONTH: month,
                                                          AUTHOR:author.text ,
                                                          ADVISER:adviser.text ,
                                                          CATEGORY: category.text,
                                                          RECOMMENDATION: recommendation.text,
                                                          KEYWORDS: keywords.text,
                                                          TAGS: '',
                                                          FACULTY: widget.user.username

                                                      );
                                                      Tools.basicDialog(
                                                          context: context,
                                                          statefulBuilder: StatefulBuilder(

                                                            builder: (loadingContext,setStateContext){
                                                              DBController.post(command: "insert_thesis", parameters: searchResult.toMap(true)).then((value) {
                                                                Navigator.of(loadingContext).pop();
                                                                Navigator.of(context).pop();
                                                                setState(() {

                                                                });

                                                              });
                                                              return Dialog(
                                                                alignment: Alignment.center,
                                                                backgroundColor: Colors.transparent,
                                                                child: Center(
                                                                  child: CircularProgressIndicator(),
                                                                ),
                                                              );
                                                            },
                                                          )
                                                      );

                                                    },
                                                    color: MyColors.secondary,
                                                    text: "Confirm",

                                                  )
                                                ],
                                              ),

                                            ],
                                          ),
                                        );
                                      }
                                  )
                              );
                            },
                            text: "Add Thesis",

                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*.7,
                      height: MediaQuery.of(context).size.width*.35,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: MyColors.secondary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white.withAlpha(150)
                      ),
                      child: FutureBuilder<String?>(
                        future: DBController.get(command: "get_all_thesis", parameters: {}),
                        builder: (context,snapshot){
                          if(!snapshot.hasData)return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                          if(snapshot.connectionState==ConnectionState.waiting) {
                            return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                          }

                          var jsonObjects = jsonDecode(snapshot.data!);
                          for(var json in jsonObjects){
                            SearchResult result = SearchResult.toObject(json);
                            if(result.TITLE.contains("(221x)delete"))continue;
                            if(result.CATEGORY.replaceAll(" ", "") .isEmpty&&searchResults.where((element) => element.TITLE.toLowerCase() == result.TITLE.toLowerCase()).isEmpty){
                              searchResults.add(result);
                            }
                            else if(searchResults.where((element) => element.TITLE.toLowerCase() == result.TITLE.toLowerCase()).isEmpty&&searchController.text.isEmpty){
                              searchResults.add(result);
                            }
                            if(searchController.text.isNotEmpty){
                                if(
                                      result.TITLE.toLowerCase().contains(searchController.text.toLowerCase())||
                                      result.YEAR.toLowerCase().contains(searchController.text.toLowerCase())||
                                      result.MONTH.toLowerCase().contains(searchController.text.toLowerCase())||
                                      result.AUTHOR.toLowerCase().contains(searchController.text.toLowerCase())
                                ){
                                  searchResults.add(result);
                                }
                            }

                          }
                          // print(searchResult[0].);
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all( 10.0),
                                child: CustomTextField(
                                  onEnter: (value){
                                    setState(() {
                                      if(value.isNotEmpty){
                                        searchController.text = value;
                                        searchResults.clear();
                                      }

                                    });



                                  },
                                  // onChange: (value){
                                  //   setState(() {
                                  //
                                  //   });
                                  // },
                                  radiusAll: 20,
                                  fillColor:MyColors.darkPrimary,
                                  filled: true,
                                  icon: Icons.search,
                                  color: Colors.white,
                                  controller: searchController,
                                  hint: "Search title,author or date(year or month)...",
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  children: searchResults.map((re) {
                                    return GestureDetector(
                                      onTap: (){
                                        widget.user.currentSelected = re.TITLE;
                                        DBController.updateUser(user: widget.user).then((value) {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(builder: (context) => DocumentPage(user: widget.user, searchResult: re)),
                                                (Route<dynamic> route) => true,
                                          );
                                        });
                                      },
                                      child: Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.all(Radius.circular(20))
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width:double.infinity,
                                                  decoration: BoxDecoration(
                                                      color:MyColors.darkPrimary,

                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20),bottomRight: Radius.circular(20),)
                                                  ),
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SelectableText(re.TITLE.replaceAll("\n", "").toTitleCase(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.white),),
                                                      // SelectableText(re.AUTHOR.replaceAll("\n", ",")),
                                                      // SelectableText(re.YEAR.replaceAll("\n", "")+" "+re.MONTH.replaceAll("\n", ""),style: TextStyle(fontWeight: FontWeight.w100,fontSize: 10),)
                                                    ],
                                                  )
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
                                              CustomTextButton(
                                                rTl: 0,
                                                rTR: 0,
                                                color: MyColors.secondary,
                                                text: "Edit",
                                                onPressed: (){

                                                  TextEditingController title = TextEditingController(text: re.TITLE);
                                                  TextEditingController author = TextEditingController(text: re.AUTHOR);
                                                  TextEditingController adviser = TextEditingController(text: re.ADVISER);
                                                  TextEditingController abstract = TextEditingController(text: re.ABTRACT);
                                                  TextEditingController recommendation = TextEditingController(text: re.RECOMMENDATION);
                                                  TextEditingController keywords = TextEditingController(text: re.KEYWORDS);
                                                  TextEditingController members = TextEditingController(text: re.MEMBERS);
                                                  TextEditingController category = TextEditingController(text: re.CATEGORY);
                                                  List<String> months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                                                  List<String> years = [];
                                                  for(int i = 1990;i <= DateTime.now().year;i++){
                                                    years.add(i.toString());
                                                  }
                                                  years.sort((a,b)=>a.compareTo(b));

                                                  String year = re.YEAR;
                                                  String month = re.MONTH;
                                                  Tools.basicDialog(context: context,
                                                      statefulBuilder: StatefulBuilder(
                                                          builder: (addThesisContext,setStateAddThesis){
                                                            return Dialog(
                                                              alignment: Alignment.center,
                                                              backgroundColor: Colors.transparent,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    alignment: Alignment.center,
                                                                    padding:EdgeInsets.all(10),
                                                                    width: MediaQuery.of(context).size.width*.7,
                                                                    height: MediaQuery.of(context).size.width*.35,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                          width: 3,
                                                                          color: MyColors.secondary,
                                                                        ),
                                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                        color: MyColors.darkPrimary
                                                                    ),
                                                                    child: Center(
                                                                        child: ListView(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text("Edit Thesis",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "Uni Sans")),
                                                                                CustomTextButton(
                                                                                  text: "Remove",
                                                                                  color: Colors.red,
                                                                                  onPressed: (){
                                                                                    re.TITLE+="(221x)delete";
                                                                                    re.DATEINPUTED = DateTime.now().toString();
                                                                                    re.FACULTY = widget.user.id;
                                                                                    DBController.get(command: "update_thesis", parameters: re.toMap(false)).then((value) {
                                                                                      setState(() {
                                                                                        searchResults.clear();
                                                                                        Navigator.of(context).pop();
                                                                                      });
                                                                                    });
                                                                                  },
                                                                                )
                                                                              ],
                                                                            ),
                                                                            // CustomTextField(hint: "Title", controller: title,color: Colors.white,),
                                                                            Row(
                                                                              children: [
                                                                                Expanded(child: CustomTextField(hint: "Title", controller: title,color: Colors.white,)),
                                                                                Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                      border:Border.all(
                                                                                          color: Colors.white,
                                                                                          width: 1
                                                                                      )
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width:200,
                                                                                        child: DropdownButton<String>(
                                                                                          dropdownColor: MyColors.darkPrimary,
                                                                                          icon: const Icon(Icons.arrow_downward),
                                                                                          elevation: 16,
                                                                                          underline: Container(
                                                                                            height: 2,
                                                                                            color: MyColors.secondary,
                                                                                          ),
                                                                                          hint: Text("Month"),
                                                                                          value: month,
                                                                                          onChanged: (value){
                                                                                            setStateAddThesis((){
                                                                                              month = value!;
                                                                                            });
                                                                                          },
                                                                                          items: months.map<DropdownMenuItem<String>>((e) {
                                                                                            return DropdownMenuItem(
                                                                                                value: e,
                                                                                                child: Text(e,style: TextStyle(color:Colors.white),)
                                                                                            );
                                                                                          }).toList(),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                                                                      SizedBox(
                                                                                        width:200,
                                                                                        child: DropdownButton<String>(
                                                                                          dropdownColor: MyColors.darkPrimary,
                                                                                          icon: const Icon(Icons.arrow_downward),
                                                                                          elevation: 16,
                                                                                          underline: Container(
                                                                                            height: 2,
                                                                                            color: MyColors.secondary,
                                                                                          ),
                                                                                          hint: Text("Year"),
                                                                                          value: year,
                                                                                          onChanged: (value){
                                                                                            setStateAddThesis((){
                                                                                              year = value!;
                                                                                            });
                                                                                          },
                                                                                          items: years.map<DropdownMenuItem<String>>((e) {

                                                                                            return DropdownMenuItem(
                                                                                                value: e,
                                                                                                child: Text(e,style: TextStyle(color:Colors.white),)
                                                                                            );
                                                                                          }).toList(),
                                                                                        ),
                                                                                      ),

                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            CustomTextField(hint: "Abstract", controller: abstract,lines: 6,color: Colors.white),
                                                                            CustomTextField(hint: "Author/s separated by comma", controller: author,lines: 1,color: Colors.white),
                                                                            CustomTextField(hint: "Adviser/s separated by comma", controller: adviser,lines: 1,color: Colors.white),
                                                                            // CustomTextField(hint: "Members", controller: members,lines: 1,color: Colors.white),
                                                                            CustomTextField(hint: "Recommendation", controller: recommendation,lines:3,color: Colors.white),
                                                                            CustomTextField(hint: "Keyword/s separated by comma", controller: keywords,lines: 1,color: Colors.white),
                                                                            CustomTextField(hint: "Category", controller: category,lines: 1,color: Colors.white),



                                                                          ],
                                                                        )
                                                                    ),
                                                                  ),
                                                                  Padding(padding: EdgeInsets.only(bottom: 10)),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      CustomTextButton(
                                                                        onPressed: (){
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        color: Colors.red,
                                                                        text: "Cancel",

                                                                      ),
                                                                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                                                      CustomTextButton(
                                                                        onPressed: (){
                                                                          SearchResult searchResult = SearchResult(
                                                                            ID: re.ID,
                                                                            TITLE: title.text,
                                                                            ABTRACT: abstract.text,
                                                                            MEMBERS: members.text,
                                                                            YEAR: year,
                                                                            MONTH: month,
                                                                            AUTHOR:author.text ,
                                                                            ADVISER:adviser.text ,
                                                                            CATEGORY: category.text,
                                                                            RECOMMENDATION: recommendation.text,
                                                                            KEYWORDS: keywords.text,
                                                                            TAGS: '',

                                                                          );
                                                                          Tools.basicDialog(
                                                                              context: context,
                                                                              statefulBuilder: StatefulBuilder(

                                                                                builder: (loadingContext,setStateContext){
                                                                                  DBController.post(command: "update_thesis", parameters: searchResult.toMap(false)).then((value) {
                                                                                    Navigator.of(loadingContext).pop();
                                                                                    Navigator.of(context).pop();
                                                                                    setState(() {
                                                                                      searchResults.clear();
                                                                                    });

                                                                                  });
                                                                                  return Dialog(
                                                                                    alignment: Alignment.center,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    child: Center(
                                                                                      child: CircularProgressIndicator(),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              )
                                                                          );

                                                                        },
                                                                        color: MyColors.secondary,
                                                                        text: "Confirm",

                                                                      )
                                                                    ],
                                                                  ),

                                                                ],
                                                              ),
                                                            );
                                                          }
                                                      )
                                                  );
                                                },
                                              )

                                            ],
                                          )
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )



              ],
            ),
          ),
        ),
      ),

    );
  }

}