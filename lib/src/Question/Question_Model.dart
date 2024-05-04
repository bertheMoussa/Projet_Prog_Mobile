class Question{

  final String id;
  final Map<String,bool> options;
  final String title;
 

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  /*factory Quiz.fromJson(Map<String, dynamic> json){

    return Quiz(
      question: json['text'],
      options: json['options'],
      category: json['category']['name'],
      difficulty: json['difficulty']['degree']
    );
  }*/


}