import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/common/app_colors.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/person_cache_image_widget.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Text(person.name, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            PersonCacheImageWidget(
              width: 260,
              height: 260,
              imageUrl: person.image,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(width: 8),
                Text(person.status, style: const TextStyle(color: Colors.white, fontSize: 16), maxLines: 1),
              ],
            ),
            const SizedBox(width: 16),
            if(person.type.isNotEmpty) ..._buildText('Type:', person.type),
            ..._buildText('Gender:', person.gender),
            ..._buildText('Number of episodes:', person.episode.length.toString()),
            ..._buildText('Species:', person.species),
            ..._buildText('Last known location:', person.location.name),
            ..._buildText('Origin:', person.origin.name),
            ..._buildText('Was created:', person.created.toString()),
          ],
        ),
      ),
    );
  }

  _buildText(String title, String subTitle) => [
        Text(title, style: const TextStyle(color: AppColors.greyColor)),
        const SizedBox(height: 4),
        Text(subTitle, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 16),
      ];
}
