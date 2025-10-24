import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');
    while (true) {
      stdout.write('Enter Your Name: ');
      String? userNameInput = stdin.readLineSync();

      if (userNameInput == null || userNameInput.isEmpty) break;
      Player currentPlayer = quiz.players
          .firstWhere((p) => p.userName == userNameInput, orElse: () {
        Player newPlayer = Player(userName: userNameInput);
        quiz.players.add(newPlayer);
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
        print('Choices: ${question.choices.join(', ')}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        // Check for null input
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer =
              Answer(questionId: question.id, answerChoice: userInput);
          quiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      int scoreInPercentage = quiz.getScoreInPercentage();
      int scoreInPoint = quiz.getScore();
      currentPlayer.score = scoreInPoint;
      print(
          '${currentPlayer.userName}, Your score: $scoreInPercentage % correct');
      print('${currentPlayer.userName}, You score in points: $scoreInPoint');

      for (Player player in quiz.players) {
        print("Player: ${player.userName} \t Score: ${player.score} points");
      }

      quiz.answers.clear();
    }
    print('--- Quiz Finished ---');
  }
}

class CreateQuizConsole {
  Quiz createNewQuiz() {
    print("\n---Creating New Quiz---");

    List<Question> questions = [];
    while (true) {
      stdout.write('Enter Question Title: ');
      String? title = stdin.readLineSync();
      if (title == null || title.isEmpty) break;

      stdout.write("Enter Choices peparated by comma: ");
      List<String> choices = (stdin.readLineSync() ?? '').split(',');

      stdout.write("Enter correct choice: ");
      String goodChoice = stdin.readLineSync() ?? '';

      stdout.write("Enter point: ");
      int point = int.tryParse(stdin.readLineSync() ?? '') ?? 10;

      questions.add(Question(title: title, choices: choices, goodChoice: goodChoice, point: point));
    }

    return Quiz(questions: questions);
  }
}
