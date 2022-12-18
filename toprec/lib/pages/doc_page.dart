

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:toprec/models/search_result.dart';
import 'package:toprec/pages/faculty_home.dart';
import '../custom_widgets/custom_text_field.dart';
import '../models/user.dart';
import '../tools/variables.dart';
import 'login.dart';

class DocumentPage extends StatefulWidget{
  const DocumentPage({Key? key,required this.user,required this.searchResult}) : super(key: key);
  final User user;
  final SearchResult searchResult;
  @override
  State<DocumentPage> createState() => _DocumentPageSate();
}
class _DocumentPageSate extends State<DocumentPage>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:MyColors.primary,
        elevation: 0,
        title:  SelectableText("TOPREC",style: TextStyle(fontFamily: 'Tually',color: Colors.white,fontSize: MediaQuery.of(context).size.width*.02),),
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
                  if(widget.user.type.toUpperCase() == UserType.FACULTY.toUpperCase())
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FacultyHome(user: widget.user)),

                        );
                      },
                      child: Text("Manage Theses",style: TextStyle(color: Colors.white),),
                    ),
                  if(widget.user.type.toUpperCase() == UserType.FACULTY.toUpperCase())
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
                  // width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(widget.searchResult.TITLE.replaceAll("\n", ""),style: TextStyle(fontSize: 50,color: Colors.white,fontWeight: FontWeight.bold),),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(widget.searchResult.AUTHOR.replaceAll("\n", ""),style: TextStyle(color: Colors.white),),
                              SelectableText(widget.searchResult.YEAR.replaceAll("\n", "")+" "+widget.searchResult.MONTH.replaceAll("\n", ""),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,fontSize: 10),)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
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
                            margin: EdgeInsets.only(top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.purple,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20),)
                                      ),
                                      child: SelectableText("Abstract",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      // height: MediaQuery.of(context).size.height*5,
                                      // margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: MyColors.darkPrimary,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight:Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                                      ),
                                      child: SelectableText(widget.searchResult.ABTRACT.replaceAll("\n", ""),style: TextStyle(color: Colors.white,fontSize: 15,),),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurpleAccent,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20),)
                                      ),
                                      child: SelectableText("Recommendation",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      // height: MediaQuery.of(context).size.height*5,
                                      // margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: MyColors.darkPrimary,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight:Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                                      ),
                                      child: SelectableText(widget.searchResult.RECOMMENDATION.replaceAll("\n", ""),style: TextStyle(color: Colors.white,fontSize: 15,),),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.purpleAccent,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20),)
                                      ),
                                      child: SelectableText("Key Words",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      // height: MediaQuery.of(context).size.height*5,
                                      // margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: MyColors.darkPrimary,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight:Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                                      ),
                                      child: SelectableText(widget.searchResult.KEYWORDS.replaceAll("\n", "")=='nan'?"Doesn't have Key words":widget.searchResult.KEYWORDS.replaceAll("\n", ""),style: TextStyle(color: Colors.white,fontSize: 15,),),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20),)
                                      ),
                                      child: SelectableText("Adviser",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      // height: MediaQuery.of(context).size.height*5,
                                      // margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: MyColors.darkPrimary,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight:Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                                      ),
                                      child: SelectableText(widget.searchResult.ADVISER.replaceAll("\n", ""),style: TextStyle(color: Colors.white,fontSize: 15,),),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.indigo,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20),)
                                      ),
                                      child: SelectableText("Categories",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.8,
                                      // height: MediaQuery.of(context).size.height*5,
                                      // margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: MyColors.darkPrimary,

                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight:Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                                      ),
                                      child: SelectableText(widget.searchResult.CATEGORY.replaceAll("\n", ""),style: TextStyle(color: Colors.white,fontSize: 15,),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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