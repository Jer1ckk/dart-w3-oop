import 'package:test/test.dart';
import "../lib/domain/quiz.dart";

main() {
  group('Quiz Score Tests', () {
    final List<Question> questions = [
      Question(
          title: "Capital of France?",
          choices: ["Paris", "London", "Rome"],
          goodChoice: "Paris"),
      Question(title: "2 + 2 = ?", choices: ["2", "4", "5"], goodChoice: "4")
    ];

    test('Both answers are correct', () {
      final quiz = Quiz(questions: questions);
      quiz.addAnswer(Answer(question: questions[0], answerChoice: "Paris"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "4"));
      expect(quiz.getScoreInPercentage(), equals(100));
    });

    test('1 is right and 1 is wrong', () {
      final quiz = Quiz(questions: questions);
      quiz.addAnswer(Answer(question: questions[0], answerChoice: "Paris"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "41"));
      expect(quiz.getScoreInPercentage(), equals(50));
    });

    test('Both answers are wrong', () {
      final quiz = Quiz(questions: questions);
      quiz.addAnswer(Answer(question: questions[0], answerChoice: "Parissss"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "5"));
      expect(quiz.getScoreInPercentage(), equals(0));
    });
  });

  group('User\'s Score Testing', () {
    final List<Question> questions = [
      Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris",
      ),
      Question(title: "2 + 2 = ?", choices: ["2", "4", "5"], goodChoice: "4")
    ];

    late Player player;
    late Quiz quiz;

    setUp(() {
      player = Player(userName: "Mr.A");
      quiz = Quiz(questions: questions);
    });

    test('should allow updating the player score after creation', () {
      quiz.addAnswer(Answer(question: questions[0], answerChoice: "Paris"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "4"));
      player.score = quiz.getScore();
      expect(player.score, equals(20));
    });

    test('should allow updating the player score after creation', () {
      quiz.addAnswer(Answer(question: questions[0], answerChoice: "Paris"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "3"));
      player.score = quiz.getScore();
      expect(player.score, equals(10));
    });

    test('reassign player\'s score', () {
      player.score = 10;
      player.score = 80;
      expect(player.score, equals(80));
    });
  });
}
