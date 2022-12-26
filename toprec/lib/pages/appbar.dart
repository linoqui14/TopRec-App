
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:toprec/pages/about.dart';
import 'package:toprec/pages/admin_page.dart';
import 'package:toprec/pages/result.dart';

import '../models/user.dart';
import '../tools/variables.dart';
import 'account.dart';
import 'faculty_home.dart';
import 'login.dart';

AppBar header(User user,BuildContext context,String page){
  return AppBar(
    backgroundColor:MyColors.primary,
    elevation: 0,
    title:  Row(
      children: [
        InkWell(
          // onHover: (isHover){
          //   print("asdasd");
          // },
            onTap: (){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Result(user:user,word: "",listOfCat: [],)),
                    (Route<dynamic> route) => false,
              );
            },
            child: Text("TOPREC   ",style: TextStyle(fontFamily: 'Tually',color: Colors.white,fontSize: MediaQuery.of(context).size.width*.02),)
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(user.type.toTitleCase()),
            SelectableText(user.firstname.toTitleCase()+" "+user.lastname.toTitleCase(),style: TextStyle(color: Colors.white,fontSize: 12),),
          ],
        )
      ],
    ),
    actions: [
      if(true)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
          child: Row(
            children: [
              // TextButton(
              //   onPressed: (){
              //
              //   },
              //   child: Text("Contact",style: TextStyle(color: Colors.white),),
              // ),
              // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
              TextButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => About(user:user)),
                        (Route<dynamic> route) => true,
                  );
                },
                child: Text("About",style: TextStyle(color: Colors.white),),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20)),

              if(user.type.toUpperCase().compareTo(UserType.ADMIN.toUpperCase())==0)
                if(page!="admin")
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage(user: user)),

                    );
                  },
                  child: Text("Admin",style: TextStyle(color: Colors.white),),
                ),
              if(user.type.toUpperCase().compareTo(UserType.ADMIN.toUpperCase())==0)
                if(page!="admin")
                Padding(padding: EdgeInsets.symmetric(horizontal: 20)),

              if(user.type.toUpperCase().compareTo(UserType.FACULTY.toUpperCase())==0)
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FacultyHome(user: user)),

                    );
                  },
                  child: Text("Manage Theses",style: TextStyle(color: Colors.white),),
                ),
              if(user.type.toUpperCase().compareTo(UserType.FACULTY.toUpperCase())==0)
                Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
              if(page!="account")
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountPage(user: user)),

                    );
                  },
                  child: Text("Account",style: TextStyle(color: Colors.white),),
                ),
              if(page!="account")
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
  );
}

