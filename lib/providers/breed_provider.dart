import 'package:flutter/material.dart';

import 'package:catbreeds/data/models/breed_model.dart';
import 'package:catbreeds/repositories/breed_repository.dart';

class BreedProvider with ChangeNotifier {
  final BreedRepository repository;

  List<BreedModel> _breeds = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _page = 0;
  String _query = '';

  List<BreedModel> get breeds => _breeds;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get query => _query;

  BreedProvider(this.repository);

  Future<void> fetchBreeds() async {
    _isLoading = true;
    _page = 0;
    notifyListeners();
    try {
      _breeds = await repository.getBreeds(page: _page);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al cargar los gatos';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreBreeds() async {
    _isLoading = true;
    _page++;
    notifyListeners();

    try {
      _breeds.addAll(await repository.getBreeds(page: _page));
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al cargar los gatos';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchBreeds(String query) async {
    _query = query;
    if (query.isEmpty) {
      fetchBreeds();
      return;
    }
    _isLoading = true;
    _page = 0;
    notifyListeners();

    try {
      _breeds = await repository.searchBreeds(query: query);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al cargar los gatos';
    }

    _isLoading = false;
    notifyListeners();
  }
}
