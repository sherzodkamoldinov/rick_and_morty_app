// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';

abstract class PersonsListState extends Equatable {
  const PersonsListState();

  @override
  List<Object?> get props => [];
}

class PersonsListEmptyState extends PersonsListState {
  @override
  List<Object?> get props => [];
}

class PersonsListLoadingState extends PersonsListState {
  final List<PersonEntity> oldPersonsList;
  final bool isFirstFetch;

  const PersonsListLoadingState(
    this.oldPersonsList, {
    this.isFirstFetch = false,
  });

  @override
  List<Object?> get props => [oldPersonsList];
}

class PersonsListLoadedState extends PersonsListState {
  final List<PersonEntity> personsList;

  const PersonsListLoadedState(this.personsList);

  @override
  List<Object?> get props => [personsList];
}

class PersonsListErrorState extends PersonsListState {
  final String message;

  const PersonsListErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
