

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toprec/pages/appbar.dart';

import '../custom_widgets/custom_text_button.dart';
import '../custom_widgets/custom_text_field.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../tools/variables.dart';
import 'doc_page.dart';
import 'package:intl/intl.dart';
class AdminPage extends StatefulWidget{
  const AdminPage({super.key,required this.user});
  final User user;
  @override
  State<StatefulWidget> createState() =>_AdminPageSate();

}

class _AdminPageSate extends State<AdminPage>{
  List<SearchResult> searchResults= [];
  TextEditingController searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: header(widget.user, context, "admin") ,
      body: SafeArea(
        child: Container(
            color:MyColors.primary,
            child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      child:  Lottie.network('https://assets10.lottiefiles.com/packages/lf20_162jfba4.json',width:  MediaQuery.of(context).size.width*.5,fit: BoxFit.fitWidth),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:EdgeInsets.symmetric(horizontal: 10),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectableText("Theses Log",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "Uni Sans"),),

                                    ],
                                  ),
                                ),
                                Container(

                                  height: MediaQuery.of(context).size.width*.35,
                                  margin: EdgeInsets.all(10),
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
                                      // print(searchResults.first.DATEINPUTED);
                                      searchResults.sort((a,b){

                                        DateTime aTime = DateTime.parse(a.DATEINPUTED);
                                        DateTime bTime = DateTime.parse(b.DATEINPUTED);
                                        return  bTime.compareTo(aTime);
                                      });
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
                                              child:  Container(

                                                height: MediaQuery.of(context).size.height*.70,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  child: ListView(
                                                    children: searchResults.map((re) {
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
                                                                              Row(
                                                                                children: [
                                                                                  Text("From : ",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w100,fontFamily: "Uni Sans")),
                                                                                  Text(re.FACULTY.toTitleCase(),style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "Uni Sans")),
                                                                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                                                                  Text("At : ",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w100,fontFamily: "Uni Sans")),
                                                                                  Text(DateFormat.yMMMd().add_jm().format(DateTime.parse(re.DATEINPUTED)) ,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "Uni Sans")),
                                                                                ],
                                                                              ),
                                                                              Divider(color: MyColors.secondary,),
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
                                              )
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:EdgeInsets.symmetric(horizontal: 10),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectableText("Manage Users",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "Uni Sans"),),
                                      CustomTextButton(
                                        color: MyColors.secondary,
                                        onPressed: (){
                                          TextEditingController username = TextEditingController();
                                          TextEditingController password = TextEditingController();
                                          TextEditingController lastname = TextEditingController();
                                          TextEditingController firstname = TextEditingController();
                                          String userType = UserType.STUDENT;
                                          Tools.basicDialog(context: context,
                                              statefulBuilder: StatefulBuilder(
                                                  builder: (context,stateUserEdit){
                                                    return Dialog(

                                                      backgroundColor:Colors.transparent,
                                                      child: Container(

                                                        padding: EdgeInsets.all(20),
                                                        width: MediaQuery.of(context).size.width*.3,
                                                        height: MediaQuery.of(context).size.height*.5,
                                                        decoration: BoxDecoration(
                                                            color: MyColors.darkPrimary,
                                                            border: Border.all(
                                                              width: 3,
                                                              color: MyColors.secondary,
                                                            ),
                                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                                        ),
                                                        child:Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [

                                                            Container(
                                                              padding: EdgeInsets.all(10),
                                                              height: MediaQuery.of(context).size.height*.3,

                                                              child: ListView(
                                                                children: [
                                                                  Text(" Account",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Uni Sans"),),
                                                                  CustomTextField(hint: "ID number", controller: username,color: Colors.white,padding: EdgeInsets.all(5),),
                                                                  // CustomTextField(hint: "Password", controller: password,color: Colors.white,padding: EdgeInsets.all(5)),

                                                                  DropdownButton(
                                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                    dropdownColor: MyColors.primary,
                                                                    value: userType,
                                                                    items:UserType.USERSTYPES.map<DropdownMenuItem<String>>((type){
                                                                      return DropdownMenuItem(
                                                                          value: type,
                                                                          child: Text(type.toTitleCase(),style: TextStyle(color: Colors.white),)
                                                                      );
                                                                    }).toList(),
                                                                    onChanged: (String? value) {
                                                                      stateUserEdit((){
                                                                        userType =  value!;
                                                                      });
                                                                    },

                                                                  ),


                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 10.0),
                                                              child: CustomTextButton(
                                                                width: double.infinity,
                                                                onPressed: (){

                                                                    if(username.text.isNotEmpty

                                                                    ){
                                                                      User user = User(type: userType, username: username.text, password: "n/a");
                                                                      DBController.post(command: "create_user", parameters: user.toMap(isNew: true)).then((value) {
                                                                        setState(() {

                                                                        });
                                                                        Navigator.of(context).pop();
                                                                      });
                                                                    }
                                                                },
                                                                color:MyColors.secondary,
                                                                text: "Add",

                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 10.0),
                                                              child: CustomTextButton(
                                                                width: double.infinity,
                                                                onPressed: (){
                                                                  Navigator.of(context).pop();
                                                                },
                                                                color:MyColors.red,
                                                                text: "Cancel",

                                                              ),
                                                            )
                                                          ],
                                                        ) ,
                                                      ),
                                                    );
                                                  }
                                              )
                                          );
                                        },
                                        text: "Add User",
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.width*.35,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                        color: MyColors.secondary,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: Colors.white.withAlpha(150)
                                  ),
                                  child: FutureBuilder<String?>(
                                    future: DBController.get(command: "get_users", parameters: {}),
                                    builder: (context,snapshot){
                                      if(!snapshot.hasData)return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                      if(snapshot.connectionState==ConnectionState.waiting) {
                                        return Center(child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fwvvesa.json',width:  MediaQuery.of(context).size.width*.1,fit: BoxFit.fitWidth),);
                                      }
                                      var jsonObjects = jsonDecode(snapshot.data!);
                                      print(jsonObjects);
                                      List<User> users = [];
                                      for(var json in jsonObjects){
                                        User user = User.toObject(json);
                                        if(user.type==UserType.ADMIN)continue;
                                        users.add(user);
                                      }
                                      return SizedBox(
                                        height: MediaQuery.of(context).size.width*.30,
                                        child: ListView(
                                          children: users.map((user) {
                                            bool isEdit = false;
                                            return Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                child: StatefulBuilder(
                                                    builder: (context,setStateUser) {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                              width:double.infinity,
                                                              decoration: BoxDecoration(
                                                                  color:MyColors.darkPrimary,

                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                                              ),
                                                              padding: EdgeInsets.all(10),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text("ID : ",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w100,fontFamily: "Uni Sans")),
                                                                      Text(user.id.toTitleCase(),style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "Uni Sans")),
                                                                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                                                      Text("Type : ",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w100,fontFamily: "Uni Sans")),
                                                                      Text(user.type.toTitleCase() ,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "Uni Sans")),
                                                                    ],
                                                                  ),
                                                                  Divider(color: MyColors.secondary,),
                                                                  SelectableText(user.firstname.toTitleCase()+" "+user.lastname.toTitleCase(),style: TextStyle(color:Colors.white),),
                                                                  // SelectableText(re.AUTHOR.replaceAll("\n", ",")),
                                                                  // SelectableText(re.YEAR.replaceAll("\n", "")+" "+re.MONTH.replaceAll("\n", ""),style: TextStyle(fontWeight: FontWeight.w100,fontSize: 10),)
                                                                ],
                                                              )
                                                          ),

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              CustomTextButton(
                                                                rTl: 0,
                                                                rTR: 0,
                                                                color: MyColors.primary,
                                                                onPressed: (){
                                                                  TextEditingController username = TextEditingController(text: user.username);
                                                                  TextEditingController password = TextEditingController(text: user.password);
                                                                  TextEditingController lastname = TextEditingController(text: user.lastname);
                                                                  TextEditingController firstname = TextEditingController(text: user.firstname);
                                                                  String userType = user.type;
                                                                  Tools.basicDialog(context: context,
                                                                      statefulBuilder: StatefulBuilder(
                                                                          builder: (context,stateUserEdit){
                                                                            return Dialog(

                                                                              backgroundColor:MyColors.darkPrimary,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                    color: MyColors.darkPrimary.withAlpha(150),
                                                                                    border: Border.all(
                                                                                      width: 3,
                                                                                      color: MyColors.secondary,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                                                ),
                                                                                padding: EdgeInsets.all(20),
                                                                                width: MediaQuery.of(context).size.width*.3,
                                                                                height: MediaQuery.of(context).size.height,
                                                                                child:Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            if(user.type!=UserType.ADMIN)
                                                                                              Text(user.type==UserType.FACULTY?"Faculty ID":"Student ID ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w100,fontFamily: "Uni Sans"),),
                                                                                            Text(user.id,style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Uni Sans"),),
                                                                                          ],
                                                                                        ),
                                                                                        Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [

                                                                                            // Text("User Type ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w100,fontFamily: "Uni Sans"),),
                                                                                            // Text(user.type,style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Uni Sans"),),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Container(
                                                                                      padding: EdgeInsets.all(10),
                                                                                      height: MediaQuery.of(context).size.height*.5,

                                                                                      child: ListView(
                                                                                        children: [
                                                                                          Text(" Account",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Uni Sans"),),
                                                                                          CustomTextField(hint: "Username", controller: username,color: !isEdit?Colors.white.withAlpha(150):Colors.white,padding: EdgeInsets.all(5),enable: isEdit,),
                                                                                          CustomTextField(hint: "Password", controller: password,color:  !isEdit?Colors.white.withAlpha(150):Colors.white,padding: EdgeInsets.all(5),enable: isEdit),
                                                                                          DropdownButton(
                                                                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                                            dropdownColor: MyColors.primary,
                                                                                            value: userType,
                                                                                            items:UserType.USERSTYPES.map<DropdownMenuItem<String>>((type){
                                                                                              return DropdownMenuItem(
                                                                                                  value: type,
                                                                                                  child: Text(type.toTitleCase(),style: TextStyle(color: Colors.white),)
                                                                                              );
                                                                                            }).toList(),
                                                                                            onChanged: (String? value) {
                                                                                              stateUserEdit((){
                                                                                                userType =  value!;
                                                                                              });
                                                                                            },

                                                                                          ),
                                                                                          Divider(color: Colors.white,),
                                                                                          Text(" Personal Information",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Uni Sans",),),
                                                                                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                                                                                          CustomTextField(hint: "Firstname", controller: firstname,color:  !isEdit?Colors.white.withAlpha(150):Colors.white,padding: EdgeInsets.all(5),enable: false),
                                                                                          CustomTextField(hint: "Lastname", controller: lastname,color:  !isEdit?Colors.white.withAlpha(150):Colors.white,padding: EdgeInsets.all(5),enable: false),

                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top: 10.0),
                                                                                      child: CustomTextButton(
                                                                                        width: double.infinity,
                                                                                        onPressed: (){

                                                                                          stateUserEdit(() {
                                                                                            isEdit = isEdit?false:true;
                                                                                          });
                                                                                          if(!isEdit){
                                                                                            if(username.text.isNotEmpty&&
                                                                                                password.text.isNotEmpty&&
                                                                                                firstname.text.isNotEmpty&&
                                                                                                lastname.text.isNotEmpty
                                                                                            ){
                                                                                              user.username=username.text;
                                                                                              user.password=password.text;
                                                                                              user.firstname=firstname.text;
                                                                                              user.lastname=lastname.text;
                                                                                              user.type = userType;
                                                                                              DBController.post(command: "update_user", parameters: user.toMap(isNew: false)).then((value) {
                                                                                                setState(() {

                                                                                                });
                                                                                                Navigator.of(context).pop();
                                                                                              });
                                                                                            }
                                                                                          }

                                                                                        },
                                                                                        color:isEdit?MyColors.secondary:MyColors.darkPrimary,
                                                                                        text: isEdit?"Save":"Edit",

                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top: 10.0),
                                                                                      child: CustomTextButton(
                                                                                        width: double.infinity,
                                                                                        onPressed: (){
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                        color:MyColors.red,
                                                                                        text: "Cancel",

                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ) ,
                                                                              ),
                                                                            );
                                                                          }
                                                                      )
                                                                  );

                                                                  setStateUser((){
                                                                    // isEdit=isEdit?false:true;
                                                                  });

                                                                  if(!isEdit){

                                                                  }
                                                                },
                                                                text: isEdit?"Save":"Edit",
                                                              ),
                                                              if(isEdit)
                                                                CustomTextButton(
                                                                  rTl: 0,
                                                                  rTR: 0,
                                                                  color: MyColors.red,
                                                                  onPressed: (){
                                                                    // setStateUser((){
                                                                    //   isEdit=isEdit?false:true;
                                                                    // });
                                                                  },
                                                                  text: "Remove",
                                                                ),
                                                            ],
                                                          ),


                                                        ],
                                                      );
                                                    }
                                                )
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
            )
        ),

      ),

    );
  }

}