import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/failures/failure.dart';
import 'package:flutter_clean_arch/core/usecases/usecase.dart';
import 'package:flutter_clean_arch/features/number-trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_clean_arch/features/number-trivia/domain/repository/number_trivia_repository.dart';

class GetRandomNumberTriviaUsecase
    extends UseCase<NumberTriviaEntity, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
