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
  static String ip = "127.0.0.1";
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
  static Future<String?> get({required String command,required Map<String,dynamic> parameters}) async{
    var res = await http.post(Uri.http('$ip:5000','/$command'),body: parameters);
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
  static Future<String?> post({required String command,required Map<String,dynamic> parameters}) async{
    var res = await http.post(Uri.http('$ip:5000','/$command'),body: parameters);
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
    print(res.body);
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
  static Future<void> basicDialog({
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
List<String> exceptions = ['a','abaft','about','above','afore','after','along',
  'amid','among','an','apud','as','aside','at','atop',
  'below','but','by','circa','down','for','from','given',
  'in','into','lest','like','mid','midst','minus','near',
  'next','of','off','on','onto','out','over','pace','past',
  'per','plus','pro','qua','round','sans','save','since','than',
  'thru','till','times','to','under','until','unto','up','upon',
  'via','vice','with','worth','the","and','nor','or','yet','so'];

extension TitleCase on String {
  String toTitleCase() {
    return this.toLowerCase().replaceAllMapped(RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
            (Match match) {
          if (exceptions.contains(match[0])) {
            return match[0]!;
          }
          return "${match[0]![0].toUpperCase()}${match[0]!.substring(1).toLowerCase()}";
        }).replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}