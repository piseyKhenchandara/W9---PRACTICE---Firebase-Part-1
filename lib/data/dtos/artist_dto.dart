import 'package:pratice_fire_base_part1/model/artists/artist.dart';

class ArtistDto {
  static const String nameKey = 'name';
  static const String genreKey = "genre";
  static const String imageUrl = "imageUrl";

  static Artist fromJson(String id, Map<String, dynamic> json) {
    return Artist(
      id: id,
      name: json[nameKey],
      genre: json[genreKey],
      imageUrl: Uri.parse(json[imageUrl]),
    );
  }
}
