
class SearchResult{
  String MONTH,YEAR,AUTHOR,ADVISER,TITLE,ABTRACT,RECOMMENDATION,KEYWORDS,MEMBERS;

  SearchResult(
      {
        required this.MONTH,
        required this.YEAR,
        required this.AUTHOR,
        required this.ADVISER,
        required this.TITLE,
        required this.ABTRACT,
        required this.RECOMMENDATION,
        required this.KEYWORDS,
        required this.MEMBERS
      });

  Map<String,dynamic> toMap(){
    return {
      'MONTH':MONTH,
      'YEAR':YEAR,
      'AUTHOR':AUTHOR,
      'ADVISER':ADVISER,
      'TITLE':TITLE,
      'ABTRACT':ABTRACT,
      'RECOMMENDATION':RECOMMENDATION,
      'KEYWORDS':KEYWORDS,
      'MEMBERS':MEMBERS,

    };
  }
  static SearchResult toObject(Map<String,dynamic> object){
    // print(object['MONTH']);
    // print(object['YEAR']);
    // print(object['AUTHOR']);
    // print(object['ADVISER']);
    // print(object['TITLE']);
    // print(object['RECOMMENDATION']);
    // print(object['MONTH']);
    //
    return SearchResult(
      MONTH:object['MONTH'],
      YEAR:object['YEAR'],
      AUTHOR:object['AUTHOR'],
      ADVISER:object['ADVISER'],
      TITLE:object['TITLE'],
      ABTRACT:object['ABSTRACT'],
      RECOMMENDATION:object['RECOMMENDATION'],
      KEYWORDS:object['KEYWORDS'],
      MEMBERS:object['MEMBERS'],
    );
  }

}