import 'dart:convert';

import 'package:flutter_clean_arch/core/failures/exceptions.dart';
import 'package:flutter_clean_arch/features/number-trivia/data/data_sources/local_data_source/local_data_source.dart';
import 'package:flutter_clean_arch/features/number-trivia/data/model/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class LocalDataSourceImpl implements LocalDataSource{
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(triviaToCache.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString('CACHED_NUMBER_TRIVIA');
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

}