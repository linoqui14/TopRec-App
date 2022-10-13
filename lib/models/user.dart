
class UserType{
  static String STUDENT = 'STUDENT';
  static String FACULTY = 'FACULTY';
  static String ADMIN = 'ADMIN';
}


class User{
  String id,type,username,password;
  User({this.id = '', required this.type, required this.username, required this.password});

  Map<String,dynamic> toMap(){
    return {
      'username':username,
      'type':type,
      'password':password,
    };
  }

  static User toObject(Map<dynamic,dynamic> object){
    return User(
      id: object['id'].toString(),
      username: object['username'],
      type: object['type'],
      password: object['password'],
    );
  }



}