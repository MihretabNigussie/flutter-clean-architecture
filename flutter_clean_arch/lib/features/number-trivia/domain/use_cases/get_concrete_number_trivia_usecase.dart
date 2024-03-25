import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/failures/failure.dart';
import 'package:flutter_clean_arch/core/usecases/usecase.dart';
import 'package:flutter_clean_arch/features/number-trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_clean_arch/features/number-trivia/domain/repository/number_trivia_repository.dart';

class GetConcreteNumberTriviaUseCase  extends UseCase<NumberTriviaEntity, Params>  {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUseCase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params {
  final int number;
  Params({required this.number});
}