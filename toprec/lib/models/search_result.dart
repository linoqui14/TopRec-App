
class SearchResult{
  String ID,MONTH,YEAR,AUTHOR,ADVISER,TITLE,ABTRACT,RECOMMENDATION,KEYWORDS,MEMBERS,TAGS,CATEGORY,FACULTY,DATEINPUTED;

  SearchResult(
      {
        this.ID = "",
        required this.MONTH,
        required this.YEAR,
        required this.AUTHOR,
        required this.ADVISER,
        required this.TITLE,
        required this.ABTRACT,
        required this.RECOMMENDATION,
        required this.KEYWORDS,
        required this.MEMBERS,
        required this.TAGS,
        this.CATEGORY = "",
        this.FACULTY = "",
        this.DATEINPUTED = ""
      });

  Map<String,dynamic> toMap(isNew){
    if(isNew){
      return {
        'month':MONTH,
        'year':YEAR,
        'author':AUTHOR,
        'adviser':ADVISER,
        'title':TITLE,
        'abstract':ABTRACT,
        'recommendation':RECOMMENDATION,
        'keywords':KEYWORDS,
        'members':MEMBERS,
        'category':CATEGORY,
        'tags':TAGS,
        'faculty':FACULTY,



      };
    }
    return {
      'month':MONTH,
      'year':YEAR,
      'author':AUTHOR,
      'adviser':ADVISER,
      'title':TITLE,
      'abstract':ABTRACT,
      'recommendation':RECOMMENDATION,
      'keywords':KEYWORDS,
      'members':MEMBERS,
      'category':CATEGORY,
      'tags':TAGS,
      'id':ID,
      'faculty':FACULTY,

    };

  }
  static SearchResult toObject(Map<String,dynamic> object){
    return SearchResult(
      ID: object['id'],
      MONTH:object['month'],
      YEAR:object['year'],
      AUTHOR:object['author'],
      ADVISER:object['adviser'],
      TITLE:object['title'],
      ABTRACT:object['abstract'],
      RECOMMENDATION:object['recommendation'],
      KEYWORDS:object['keywords'],
      MEMBERS:object['members'],
      TAGS:object['tags'],
      CATEGORY:object['category'],
      DATEINPUTED:object['dateInputed'],
      FACULTY: object['faculty'],
    );
  }

}