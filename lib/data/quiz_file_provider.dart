import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz() {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception("Quiz file not found: $filePath");
    }

    final content = file.readAsStringSync();
    final data = jsonDecode(content) as Map<String, dynamic>;

    var questionsJson = data['questions'] as List;
    List<Question> questions = questionsJson.map((q) {
      return Question(
        id: q['id'],
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        point: q['point'] ?? 10,
      );
    }).toList();

    return Quiz(id: data['id'], questions: questions);
  }

  void writeQuiz(Quiz quiz) {
    Map<String, dynamic> data = {
      'id': quiz.id,
      'questions': quiz.questions.map((q) {
        return {
          'id': q.id,
          'title': q.title,
          'choices': q.choices,
          'goodChoice': q.goodChoice,
          'point': q.point,
        };
      }).toList(),
    };

    final file = File(filePath);
    // file.writeAsStringSync(jsonEncode(data),
    //     mode: FileMode.append, flush: true);
    file.writeAsStringSync(jsonEncode(data), flush: true);
  }
}
