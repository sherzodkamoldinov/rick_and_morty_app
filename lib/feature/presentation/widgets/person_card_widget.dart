import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/common/app_colors.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonCardWidget extends StatelessWidget {
  final PersonEntity person;
  const PersonCardWidget({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonDetailPage(person: person),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // PERSON IMAGE
            PersonCacheImageWidget(
              width: 160,
              height: 160,
              imageUrl: person.image,
            ),
            const SizedBox(width: 16),
            // PERSON INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(person.name, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: person.status == 'Alive' ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${person.status} - ${person.species}',
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Last Known location:', style: TextStyle(color: AppColors.greyColor)),
                  const SizedBox(height: 4),
                  Text(
                    person.location.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  const Text('Origin:', style: TextStyle(color: AppColors.greyColor)),
                  const SizedBox(height: 4),
                  Text(
                    person.origin.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const SizedBox(width: 16)
          ],
        ),
      ),
    );
  }
}
