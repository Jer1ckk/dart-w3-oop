class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int point;

  Question(
      {required this.title,
      required this.choices,
      required this.goodChoice,
      this.point = 10});
}

class Answer {
  final Question question;
  final String answerChoice;

  Answer({required this.question, required this.answerChoice});

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz {
  List<Question> questions;
  List<Answer> answers = [];

  Quiz({required this.questions});

  void addAnswer(Answer asnwer) {
    this.answers.add(asnwer);
  }

  int getScore() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalSCore += answer.question.point;
      }
    }
    return totalSCore;
  }

  int getScoreInPercentage() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalSCore++;
      }
    }
    return ((totalSCore / questions.length) * 100).toInt();
  }
}

class Player {
  final String userName;
  int _score;

  Player({required this.userName, int score = 0}):_score=score;

  int get score => _score;
  set score(int value) => value>=0? this._score=value: throw Exception("Score cannot be negative!");
}
