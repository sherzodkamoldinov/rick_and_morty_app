import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
