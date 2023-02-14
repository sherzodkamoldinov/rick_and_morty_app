import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/person_list_cubit/person_list_state.dart';

// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = 'Server Failure';
// ignore: constant_identifier_names
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonsListCubit extends Cubit<PersonsListState> {
  final GetAllPersons getAllPersons;
  PersonsListCubit({required this.getAllPersons}) : super(PersonsListEmptyState());

  int page = 1;
  void loadPerson() async {
    if (state is PersonsListLoadingState) return;

    final currentState = state;

    var oldPersons = <PersonEntity>[];
    if (currentState is PersonsListLoadedState) {
      oldPersons = currentState.personsList;
    }

    emit(PersonsListLoadingState(oldPersons, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    emit(
      failureOrPerson.fold(
        (failure) => PersonsListErrorState(message: _mapFailureToMessage(failure)),
        (character) {
          page++;
          final persons = (state as PersonsListLoadingState).oldPersonsList;
          persons.addAll(character);
          return PersonsListLoadedState(persons);
        },
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
