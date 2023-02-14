// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';

import 'package:rick_and_morty_app/feature/domain/usecases/search_person.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_state.dart';

// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = 'Server Failure';
// ignore: constant_identifier_names
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;
  PersonSearchBloc({required this.searchPerson}) : super(PersonEmptyState()) {
    on<SearchPersonsEvent>((event, emit) async{
      emit(PersonSearchLoadingState());
      final failureOrPerson = await searchPerson(SearchPersonParams(query: event.personQuery));
      emit(
        failureOrPerson.fold(
          (failure) => PersonSearchErrorState(message: _mapFailureToMessage(failure)), 
          (persons) => PersonSearchLoadedState(persons: persons),
          )
        );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
