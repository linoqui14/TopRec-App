
class RecommendedTopic {
  String topic;

  RecommendedTopic({required this.topic});

  static RecommendedTopic toObject(Map<String,dynamic> object){
    return RecommendedTopic(
      topic: object['topic']
    );
  }
}