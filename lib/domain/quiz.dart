import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int point;

  Question(
      {String? id,
      required this.title,
      required this.choices,
      required this.goodChoice,
      this.point = 10})
      : id = id ?? uuid.v4();
}

class Answer {
  final String id;
  final String questionId;
  final String answerChoice;

  Answer({String? id, required this.questionId, required this.answerChoice})
      : id = id ?? uuid.v4();

  bool isGood(Quiz quiz) {
    Question? question = quiz.getQuestionById(questionId);
    if (question == null) return false;
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz {
  final String id;
  List<Question> questions;
  List<Answer> answers = [];

  Quiz({String? id, required this.questions}) : id = id ?? uuid.v4();

  void addAnswer(Answer answer) {
    this.answers.add(answer);
  }

  Question? getQuestionById(String id) {
    for (var question in questions) {
      if (question.id == id) return question;
    }
    return null;
  }

  Answer? getAnswerById(String id) {
    for (var answer in answers) {
      if (answer.id == id) return answer;
    }
    return null;
  }

  int getScore() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood(this)) {
        totalSCore += getQuestionById(answer.questionId)?.point ?? 0;
      }
    }
    return totalSCore;
  }

  int getScoreInPercentage() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood(this)) {
        totalSCore++;
      }
    }
    return ((totalSCore / questions.length) * 100).toInt();
  }
}

class Player {
  final String userName;
  int _score;

  Player({required this.userName, int score = 0}) : _score = score;

  int get score => _score;
  set score(int value) => value >= 0
      ? this._score = value
      : throw Exception("Score cannot be negative!");
}
