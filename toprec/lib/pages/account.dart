
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:toprec/custom_widgets/custom_text_button.dart';
import 'package:toprec/models/user.dart';
import 'package:toprec/pages/login.dart';

import '../custom_widgets/custom_text_field.dart';
import '../tools/variables.dart';
import 'appbar.dart';
import 'faculty_home.dart';

class AccountPage extends StatefulWidget{
  const AccountPage({super.key,required this.user});
  final User user;
  @override
  State<StatefulWidget> createState()=>_AccountPageState();

}
class _AccountPageState extends State<AccountPage>{
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController firstname = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    username.text = widget.user.username;
    password.text = widget.user.password;
    lastname.text = widget.user.lastname;
    firstname.text = widget.user.firstname;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: header(widget.user,context,"account"),
        body: SafeArea(
          child: Container(
            color: MyColors.primary,
            child: Center(
              child:  Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    child:  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_arirrjzh.json',width:  MediaQuery.of(context).size.width*.5,fit: BoxFit.fitWidth),
                  ),

                  Container(
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
                                if(widget.user.type!=UserType.ADMIN)
                                  Text(widget.user.type==UserType.FACULTY?"Faculty ID":"Student ID ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w100,fontFamily: "Uni Sans"),),
                                Text(widget.user.id,style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Uni Sans"),),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("User Type ",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w100,fontFamily: "Uni Sans"),),
                                Text(widget.user.type,style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Uni Sans"),),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height*.5,
                          decoration: BoxDecoration(
                              color: MyColors.darkPrimary.withAlpha(150),
                              border: Border.all(
                                width: 3,
                                color: MyColors.secondary,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: ListView(
                            children: [
                              Text(" Account",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Uni Sans"),),
                              CustomTextField(hint: "Username", controller: username,color: !isEdit?Colors.white.withAlpha(150):Colors.white,padding: EdgeInsets.all(5),enable: isEdit,),
                              CustomTextField(hint: "Password", controller: password,color:  !isEdit?Colors.white.withAlpha(150):Colors.white,padding: EdgeInsets.all(5),enable: isEdit),
                              Divider(color: Colors.white,),
                              Text(" Personal Information",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Uni Sans",),),
                              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                              CustomTextField(hint: "Firstname", controller: firstname,color:  !isEdit?Colors.white.withAlpha(150):Colors.white,padding: EdgeInsets.all(5),enable: isEdit),
                              CustomTextField(hint: "Lastname", controller: lastname,color:  !isEdit?Colors.white.withAlpha(150):Colors.white,padding: EdgeInsets.all(5),enable: isEdit),
                              CustomTextButton(
                                onPressed: (){
                                    
                                    setState(() {
                                      isEdit = isEdit?false:true;
                                    });
                                    if(username.text.isNotEmpty&&
                                        password.text.isNotEmpty&&
                                        firstname.text.isNotEmpty&&
                                        lastname.text.isNotEmpty
                                    ){
                                      widget.user.username=username.text;
                                      widget.user.password=password.text;
                                      widget.user.firstname=firstname.text;
                                      widget.user.lastname=lastname.text;
                                      DBController.post(command: "update_user", parameters: widget.user.toMap(isNew: false));
                                    }
                                },
                                color:isEdit?MyColors.secondary:MyColors.darkPrimary,
                                text: isEdit?"Save":"Edit",

                              )
                            ],
                          ),
                        )
                      ],
                    ) ,
                  )

                ],
              ),
            ),
          ),
        )

    );
  }

}