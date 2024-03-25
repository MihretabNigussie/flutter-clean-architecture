import 'package:flutter_clean_arch/features/number-trivia/data/model/number_trivia_model.dart';

abstract class LocalDataSource {
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
  Future<NumberTriviaModel> getLastNumberTrivia();
}
