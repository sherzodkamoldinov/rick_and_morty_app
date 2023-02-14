import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/person_card_widget.dart';

class PersonsListWidget extends StatelessWidget {
  PersonsListWidget({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            BlocProvider.of<PersonsListCubit>(context).loadPerson();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    bool isLoading = false;

    return BlocBuilder<PersonsListCubit, PersonsListState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];
        if (state is PersonsListLoadingState && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonsListLoadingState) {
          persons = state.oldPersonsList;
          isLoading = true;
        } else if (state is PersonsListLoadedState) {
          persons = state.personsList;
        } else if (state is PersonsListErrorState) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500)));
        }
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCardWidget(person: persons[index]);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) => Divider(color: Colors.grey[400]),
          itemCount: persons.length + (isLoading ? 1 : 0),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
