// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rick_and_morty_app/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rick_and_morty_app/feature/data/models/person_model.dart';

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

abstract class PersonLocalDataSource {
  /// gets the cached [List<PersonModel>] which was gotter the last time
  /// the user had an internet connection
  ///
  /// throws[CacheException] if no cached data is present.

  Future<List<PersonModel>> getLastPersonFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonFromCache() async {
    final jsonPersonsList = sharedPreferences.getStringList(CACHED_PERSONS_LIST);

    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList.map((person) => PersonModel.fromJson(json.decode(person))).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) async {
    final List<String> jsonPersonsList = persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    print('Persons to write Cache: ${jsonPersonsList.length}');
    Future.value(jsonPersonsList);
  }
}
