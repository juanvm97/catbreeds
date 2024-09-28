import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:catbreeds/data/models/breed_model.dart';

class BreedApiService {
  static const String _baseUrl = 'https://api.thecatapi.com/v1';
  final headers = {
    'x-api-key': dotenv.env['API_KEY'] ?? '',
  };

  Future<List<BreedModel>> fetchBreeds({int page = 0}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/breeds?limit=10&page=$page'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((breed) => BreedModel.fromJson(breed)).toList();
    } else {
      throw Exception('Error al cargar los gatos');
    }
  }

  Future<List<BreedModel>> searchBreeds({required String query}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/breeds/search?q=$query'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((breed) => BreedModel.fromJson(breed)).toList();
    } else {
      throw Exception('Error al cargar los gatos');
    }
  }
}
