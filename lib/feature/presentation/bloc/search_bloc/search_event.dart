// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchPersonsEvent extends PersonSearchEvent {
  final String personQuery;
  const SearchPersonsEvent(this.personQuery);
}
