import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/persons_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: PersonsListWidget(),
    );
  }
}
