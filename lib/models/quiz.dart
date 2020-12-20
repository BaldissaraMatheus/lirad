import './option.dart';

class Quiz {
  final String title;
  final String question;
  final List<Option> options;
  final int answer;
  final List<String> tags;
  
  Quiz(this.title, this.question, this.options, this.answer, this.tags);

  factory Quiz.fromMap(Map<String, dynamic> snippet) {
    return Quiz(
      snippet['title'],
      snippet['question'],
      snippet['options']
        .map((option) => Option(option['description'], option['explanation']))
        .toList()
        .cast<Option>(),
      snippet['answer'],
      snippet['tags'].cast<String>()
    );
  }
}