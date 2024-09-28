import 'package:catbreeds/data/models/breed_model.dart';
import 'package:catbreeds/data/services/breed_api_service.dart';

class BreedRepository {
  final BreedApiService apiService;

  BreedRepository(this.apiService);

  Future<List<BreedModel>> getBreeds({int page = 0}) async {
    return await apiService.fetchBreeds(page: page);
  }

  Future<List<BreedModel>> searchBreeds({required String query}) async {
    return await apiService.searchBreeds(query: query);
  }
}
