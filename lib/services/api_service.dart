import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petpal_health/models/facts.dart';

class ApiService {
  final String catFactsUrl = 'https://meowfacts.herokuapp.com';
  final String dogFactsUrl = 'https://dogapi.dog/api/v2';

  Future<List<Facts>> fetchDogFacts() async {
    final List<Facts> allFacts = [];

    for (int i = 0; i < 8; i++) {
      final response = await http.get(Uri.parse('$dogFactsUrl/facts'));

      if (response.statusCode == 200) {
        var factJson = json.decode(response.body)['data'][0];
        Facts fact = Facts.fromJsonDog(factJson);
        allFacts.add(fact);
      } else {
        throw Exception('Failed to load dog facts');
      }

      await Future.delayed(const Duration(seconds: 1));
    }

    return allFacts;
  }

  Future<List<Facts>> fetchCatFacts() async {
    final response = await http.get(Uri.parse('$catFactsUrl/?count=10'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> factsJson = jsonResponse['data'];
      return factsJson.map((fact) => Facts.fromJsonCat(fact)).toList();
    } else {
      throw Exception('Failed to load dog facts');
    }
  }
}
