
class UserType{
  static String STUDENT = 'STUDENT';
  static String FACULTY = 'FACULTY';
  static String ADMIN = 'ADMIN';
}


class User{
  String id,type,username,password,recentSearch,currentSelected;
  User({this.id = '', required this.type, required this.username, required this.password,this.recentSearch = '',this.currentSelected = ''});

  Map<String,dynamic> toMap({required bool isNew}){
    return {
      'id':isNew?'n/a':id,
      'username':username,
      'type':type,
      'password':password,
      'recentSearch':recentSearch,
      'currentSelected':currentSelected
    };
  }

  static User toObject(Map<dynamic,dynamic> object){
    String recentSearch = '';
    String currentSelected = '';

    try{
      recentSearch = object['recentSearch'];
      // currentSelected = object['currentSelected'];
    }catch(e){
      recentSearch = '';
    }
    return User(
        id: object['id'].toString(),
        username: object['username'],
        type: object['type'],
        password: object['password'],
        recentSearch:recentSearch,
        currentSelected:currentSelected
    );
  }



}