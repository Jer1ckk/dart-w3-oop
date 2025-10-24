import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_file_provider.dart';

void main() {

  //do quiz...
  var filePath = 'assets/quiz.json';
  QuizRepository repo = QuizRepository(filePath);
  Quiz quiz = repo.readQuiz();

  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();


  // create new quiz and save to file
  var filePathWrite = 'assets/quiz-input.json';
  QuizRepository repo2 = QuizRepository(filePathWrite);

  CreateQuizConsole createQuizConsole = CreateQuizConsole();
  Quiz newQuiz = createQuizConsole.createNewQuiz();
  repo2.writeQuiz(newQuiz);
}
