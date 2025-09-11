import 'dart:convert';

import 'package:creappi_conge/models/demande_conge.dart';
import 'package:http/http.dart';

abstract class DemandesRepository {
  Future<List<DemandeConge>> recupererListeDemandeCongesEmploye({
    required String token,
  });
  Future<List<DemandeConge>> recupererListeDemandeCongesAdmin({
    required String token,
  });
  Future<void> soumettreDemandeDeConge({
    required String token,
    required String dateDebut,
    required String dateFin,
    required String motif,
  });
}

class LocalDemandesRepository implements DemandesRepository {
  @override
  Future<List<DemandeConge>> recupererListeDemandeCongesEmploye({
    required String token,
  }) async {
    try {
      // Essayer différentes URLs
      const requestUrl = 'http://localhost:3000/api/v1/me/conges/demandes';
      //const requestUrl = 'https://httpbin.org/anything';
      final uri = Uri.parse(requestUrl);

      final request = Request('GET', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'application/json';

      final response = await Response.fromStream(await Client().send(request));

      if (response.statusCode == 200) {
        final dataList = json.decode(response.body) as List<dynamic>;

        final demandes = <DemandeConge>[];

        for (final data in dataList) {
          final demande = DemandeConge.fromJson(data as Map<String, dynamic>);

          demandes.add(demande);
        }

        return demandes;
      } else {
        throw Exception(
          'Erreur lors de la connexion: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DemandeConge>> recupererListeDemandeCongesAdmin({
    required String token,
  }) async {
    try {
      // Essayer différentes URLs
      const requestUrl = 'http://localhost:3000/api/v1/admin/conges/demandes';
      //const requestUrl = 'https://httpbin.org/anything';
      final uri = Uri.parse(requestUrl);

      final request = Request('GET', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'application/json';

      final response = await Response.fromStream(await Client().send(request));

      if (response.statusCode == 200) {
        final dataList = json.decode(response.body) as List<dynamic>;

        final demandes = <DemandeConge>[];

        for (final data in dataList) {
          final demande = DemandeConge.fromJson(data as Map<String, dynamic>);

          demandes.add(demande);
        }

        return demandes;
      } else {
        throw Exception(
          'Erreur lors de la connexion: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> soumettreDemandeDeConge({
    required String token,
    required String dateDebut,
    required String dateFin,
    required String motif,
  }) async {
    try {
      // Essayer différentes URLs
      const requestUrl = 'http://localhost:3000/api/v1/conges/demandes';
      //const requestUrl = 'https://httpbin.org/anything';
      final uri = Uri.parse(requestUrl);

      final requestBody = {
        'date_debut': dateDebut,
        'date_fin': dateFin,
        'motif': motif,
      };

      final request = Request('POST', uri)
        ..bodyBytes = utf8.encode(jsonEncode(requestBody))
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'application/json';

      final response = await Response.fromStream(await Client().send(request));
      print('response : ${response.body}');

      if (response.statusCode == 201) {
        print('demande de conge : ${response.body}');
        return;
      } else {
        throw Exception(
          'Erreur lors de la connexion: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}

class RenderDemandesRepository implements DemandesRepository {
  @override
  Future<List<DemandeConge>> recupererListeDemandeCongesEmploye({
    required String token,
  }) async {
    try {
      // Essayer différentes URLs
      const requestUrl =
          'https://creappi-conges-api.onrender.com/api/v1/me/conges/demandes';

      final uri = Uri.parse(requestUrl);

      final request = Request('GET', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'application/json';

      final response = await Response.fromStream(await Client().send(request));

      if (response.statusCode == 200) {
        final dataList = json.decode(response.body) as List<dynamic>;

        final demandes = <DemandeConge>[];

        for (final data in dataList) {
          final demande = DemandeConge.fromJson(data as Map<String, dynamic>);

          demandes.add(demande);
        }

        return demandes;
      } else {
        throw Exception(
          'Erreur lors de la connexion: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DemandeConge>> recupererListeDemandeCongesAdmin({
    required String token,
  }) async {
    try {
      // Essayer différentes URLs
      const requestUrl =
          'https://creappi-conges-api.onrender.com/api/v1/admin/conges/demandes';
      //const requestUrl = 'https://httpbin.org/anything';
      final uri = Uri.parse(requestUrl);

      final request = Request('GET', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'application/json';

      final response = await Response.fromStream(await Client().send(request));

      if (response.statusCode == 200) {
        final dataList = json.decode(response.body) as List<dynamic>;

        final demandes = <DemandeConge>[];

        for (final data in dataList) {
          final demande = DemandeConge.fromJson(data as Map<String, dynamic>);

          demandes.add(demande);
        }

        return demandes;
      } else {
        throw Exception(
          'Erreur lors de la connexion: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> soumettreDemandeDeConge({
    required String token,
    required String dateDebut,
    required String dateFin,
    required String motif,
  }) async {
    try {
      // Essayer différentes URLs
      const requestUrl =
          'https://creappi-conges-api.onrender.com/api/v1/conges/demandes';
      //const requestUrl = 'https://httpbin.org/anything';
      final uri = Uri.parse(requestUrl);

      final requestBody = {
        'date_debut': dateDebut,
        'date_fin': dateFin,
        'motif': motif,
      };

      final request = Request('POST', uri)
        ..bodyBytes = utf8.encode(jsonEncode(requestBody))
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'application/json';

      final response = await Response.fromStream(await Client().send(request));
      print('response : ${response.body}');

      if (response.statusCode == 201) {
        print('demande de conge : ${response.body}');
        return;
      } else {
        throw Exception(
          'Erreur lors de la connexion: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
