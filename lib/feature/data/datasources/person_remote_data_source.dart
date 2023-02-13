// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/core/error/exception.dart';

import 'package:rick_and_morty_app/feature/data/models/person_model.dart';

abstract class PersonRemoteDataSource {
  /// calls the https://rickandmortyapi.com/api/character/?page=1 endpoint.
  ///
  /// throws a [ServerException] for all error codes.
  Future<List<PersonModel>> getAllPersons(int page);

  /// calls the https://rickandmortyapi.com/api/character/?name=rick endpoint.
  ///
  /// throws a [ServerException] for all error codes.
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;
  PersonRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    debugPrint(url);
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List).map((person) => PersonModel.fromJson(person)).toList();
    } else {
      throw ServerException();
    }
  }
}
