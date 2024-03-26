import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/core/failures/failure.dart';
import 'package:flutter_clean_arch/core/usecases/usecase.dart';
import 'package:flutter_clean_arch/core/util/input_converter.dart';
import 'package:flutter_clean_arch/features/number-trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_clean_arch/features/number-trivia/domain/use_cases/get_concrete_number_trivia_usecase.dart';
import 'package:flutter_clean_arch/features/number-trivia/domain/use_cases/get_random_number_trivia_usecase.dart';
import 'package:flutter_clean_arch/features/number-trivia/presentation/bloc/number_trivia_bloc/number_trivia_event.dart';
import 'package:flutter_clean_arch/features/number-trivia/presentation/bloc/number_trivia_bloc/number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUseCase getConcreteNumberTrivia;
  final GetRandomNumberTriviaUsecase getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
    super.initialState, {
    required GetConcreteNumberTriviaUseCase concrete,
    required GetRandomNumberTriviaUsecase random,
    required this.inputConverter,
  })  : getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  NumberTriviaState get initialState => Empty();

  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia = await getConcreteNumberTrivia(
            Params(number: integer),
          );
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(
        NoParams(),
      );
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTriviaEntity> either,
  ) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
