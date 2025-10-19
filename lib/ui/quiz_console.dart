import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    List<Player> players = [];
    print('--- Welcome to the Quiz ---\n');

    while (true) {
      stdout.write('Enter Your Name: ');
      String? userNameInput = stdin.readLineSync();

      if (userNameInput == null || userNameInput.isEmpty) break;
      Player player =
          players.firstWhere((p) => p.userName == userNameInput, orElse: () {
        Player newPlayer = Player(userName: userNameInput);
        players.add(newPlayer);
        return newPlayer;
      });

      // var existingPlayer = players.where((p) => p.userName == userNameInput);

      // if (existingPlayer.isEmpty) {
      //   player = Player(userName: userNameInput);
      //   players.add(player);
      // }
      // else {
      //   player = existingPlayer.first;
      // }

      for (var question in quiz.questions) {
        print('Question: ${question.title} - (${question.point} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        // Check for null input
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          quiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      int scoreInPercentage = quiz.getScoreInPercentage();
      int scoreInPoint = quiz.getScore();
      player.score = scoreInPoint;
      print('${player.userName} Your score: $scoreInPercentage % correct');
      print('${player.userName} You score in points: ${scoreInPoint}');

      for (Player player in players) {
        print("Player: ${player.userName} \t Score: ${player.score} points");
      }

      quiz.answers.clear();
    }
    print('--- Quiz Finished ---');
  }
}
