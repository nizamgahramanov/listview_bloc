import 'package:equatable/equatable.dart';

class Destination extends Equatable {
  final String? id;
  final String name;
  final String overview;
  final String overviewAz;
  final String region;
  final String regionAz;
  final String category;
  List<dynamic> photoUrl;

  Destination({
    required this.id,
    required this.name,
    required this.overview,
    required this.overviewAz,
    required this.region,
    required this.regionAz,
    required this.category,
    required this.photoUrl,
  });
  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'overview_az': overviewAz,
      'region': region,
      'region_az': regionAz,
      'category': category,
      'photo_url': photoUrl,
    };
  }

  Destination.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        name = firestoreMap['name'],
        overview = firestoreMap['overview'],
        overviewAz = firestoreMap['overview_az'],
        region = firestoreMap['region'],
        regionAz = firestoreMap['region_az'],
        category = firestoreMap['category'],
        photoUrl = firestoreMap['photo_url'].cast<String>();

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        overviewAz,
        region,
        regionAz,
        category,
        photoUrl,
      ];
}
