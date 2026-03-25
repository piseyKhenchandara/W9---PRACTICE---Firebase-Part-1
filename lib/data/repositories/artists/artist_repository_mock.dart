import '../../../model/artists/artist.dart';
import 'artist_repository.dart';

class ArtistRepositoryMock implements ArtistRepository {

  @override
  Future<List<Artist>> fetchArtists() async {

    throw Exception("Mock not implemented");
    
  }
}
