import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/failures/failure.dart';
import 'package:flutter_clean_arch/features/number-trivia/domain/entities/number_trivia_entity.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia();
}
