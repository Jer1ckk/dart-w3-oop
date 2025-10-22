import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_file_provider.dart';

void main() {
  var filePath = 'assets/quiz.json';

  QuizRepository repo = QuizRepository(filePath);
  Quiz quiz = repo.readQuiz();

  QuizConsole console = QuizConsole(quiz: quiz);

  console.startQuiz();

  var filePathWrite = 'assets/quiz-input.json';
  QuizRepository repo2 = QuizRepository(filePathWrite);
  repo2.writeQuiz(quiz);
}
