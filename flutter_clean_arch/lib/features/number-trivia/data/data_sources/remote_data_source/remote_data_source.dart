import 'package:flutter_clean_arch/features/number-trivia/data/model/number_trivia_model.dart';

abstract class RemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
