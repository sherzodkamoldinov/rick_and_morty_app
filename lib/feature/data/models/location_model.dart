import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required super.name, required super.url});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(name: json['name'], url: json['url']);
  }

  Map toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
