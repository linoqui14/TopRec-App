import 'dart:ui';
import 'dart:io' show File, Platform, stdout;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';
class MyColors{
  static const Color red = Color(0xffBF1744);
  static const Color darkBlue = Color(0xff0433BF);
  static const Color grey = Color(0xff434A59);
  static const Color deadBlue = Color(0xff558ED9);
  static const Color skyBlueDead = Color(0xffA7C8F2);
  static const Color black = Color(0xff151515);
  static const Color primary = Color(0xff1A1851);
  static const Color secondary = Color(0xffF9A521);
  static const Color darkPrimary = Color(0xff080036);

}

class Constants{
  static String hostname = Platform.localHostname;
}
class DBController{
  static String ip = "192.168.1.6";
  static Future<bool> testConnection() async{
    String phpurl = "http://$ip:5000/is_connected";
    var res = await http.post(Uri.parse(phpurl), body: {
    }); //sending post request with header data
    return int.parse(res.body)==1?true:false;
  }

  static Future<User?> getUser({required String username,required String password}) async{
    String phpurl = "http://$ip:5000/get_user";
    var res = await http.post(Uri.http('$ip:5000','/get_user'),body: {'username':username,'password':password});
    // print(res.body);
    try {
      User user = User.toObject(json.decode(res.body));
      return user;
    }
    catch(e){
      return null;
    }
  }
  static Future<String?> getRecommended({required String words}) async{
    String phpurl = "http://$ip:5000/generate_topic";
    var res = await http.post(Uri.http('$ip:5000','/generate_topic'),body: {'words':words,});
    return res.body;
    //
    // try {
    //   User user = User.toObject(json.decode(res.body));
    //   return user;
    // }
    // catch(e){
    //   return null;
    // }
  }
  static Future<String?> getSearch({required String words}) async{
    var res = await http.post(Uri.http('$ip:5000','/get_search'),body: {'words':words,});
    // print(res.body);
    return res.body;

    //
    // try {
    //   User user = User.toObject(json.decode(res.body));
    //   return user;
    // }
    // catch(e){
    //   return null;
    // }
  }


  static Future<bool> createUser({required User user}) async{
    String phpurl = "http://$ip:5000/create_user";
    var res = await http.post(Uri.parse(phpurl),body: user.toMap(isNew: true));
    // print(res.body);
    return res.body.split("{").length>1?true:false;
  }

  static Future<bool> updateUser({required User user}) async{
    var res = await http.post(Uri.http('$ip:5000','/update_user'),body: user.toMap(isNew: false));
    // print(user.recentSearch);
    return res.body.split("{").length>1?true:false;
  }



}
class Tools{



  // static Future<File> downloadFile(String url, String filename) async {
  //   http.Client client = new http.Client();
  //   var req = await client.get(Uri.parse(url));
  //   var bytes = req.bodyBytes;
  //   String dir = './images';
  //   File file = new File('$dir/$filename');
  //   await file.writeAsBytes(bytes);
  //   return file;
  // }
  Future<void> basicDialog({
    required BuildContext context,
    required StatefulBuilder statefulBuilder
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return statefulBuilder;
      },
    );
  }


}