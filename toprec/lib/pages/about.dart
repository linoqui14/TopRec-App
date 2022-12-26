



import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/user.dart';
import '../tools/variables.dart';
import 'appbar.dart';

class About extends StatelessWidget{
  const About({super.key,required this.user,});
  final User user;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: header(
        user,
        context,
        "about"
      ),
      body: SafeArea(
        child: Container(
            color:MyColors.primary,
            child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      child:  Lottie.network('https://assets10.lottiefiles.com/packages/lf20_162jfba4.json',width:  MediaQuery.of(context).size.width*.5,fit: BoxFit.cover),
                    ),
                    Container(
                      alignment:Alignment.center,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width*.35,
                      child: Container(
                        alignment:Alignment.center,
                        // height: MediaQuery.of(context).size.width*.35,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: MyColors.secondary,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: MyColors.darkPrimary.withAlpha(150)
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text("About",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "Uni Sans"),),
                              Text("TopRec is a recommender system that allows the:  student to view theses;"
                                  "admin to uodate the system and manage, add, delete users and faculty; "
                                  "and faculty to manage, add, and delete approved theses of BSIT students "
                                  "of University of Science and Technology of Southern Philippines. The system "
                                  "utilizes text mining to recommend a thesis topic that you could work on based "
                                  "on what you search on the search bar. It also shows the related theses of BSIT "
                                  "students for referencial purposes.",maxLines: 20,style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.center,),
                              Divider(color: Colors.white,),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text("Team",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "Uni Sans"),),
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            child: Image.asset("img/lizit.jpg",fit:BoxFit.fitHeight,width: 150,height: 150,alignment: Alignment.topCenter,)
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 5)),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Lyzette B. Cagulada",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - Programmer",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("ID Number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - 2019101401",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Phone Number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - 09619316120",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Email Address",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - lyzettecagulada16@gmail.com",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(color: Colors.white,thickness: 0.5,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            child: Image.asset("img/myres.jpg",fit: BoxFit.fitHeight,width: 150,height: 150,alignment: Alignment.topCenter,)
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 5)),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Myres Jade S. Sulapas ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - Programmer",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("ID Number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - 2019101592",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Phone Number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - 09532610736",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Email Address",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - myressalvs@gmail.com",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(color: Colors.white,thickness: 0.5,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            child: Image.asset("img/dzam.jpg",fit: BoxFit.fitWidth,width: 150,height: 150,alignment: Alignment.topCenter,)
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 5)),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Dzamlhij E. Fajardo",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - Tester",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("ID Number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - 2016100242",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Phone Number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - 09654714044",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Email Address",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - dzamfajardo@gmail.com",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(color: Colors.white,thickness: 0.5,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            child: Image.asset("img/leven.jpg",fit: BoxFit.fitHeight,width: 150,height: 150,alignment: Alignment.topCenter,)
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 5)),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Leven Margarette G. Miole ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - Project Manager",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("ID Number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - 2019101622 ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Phone Number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - 09262427535 ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Email Address",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text(" - levmargarette@gmail.com",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),),
                                            ],
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
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