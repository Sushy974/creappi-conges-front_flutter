import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _token;

  // Configuration du token
  void setToken(String? token) {
    _token = token;
  }

  String? get token => _token;

  // Headers par défaut
  Map<String, String> get _defaultHeaders => {
    ApiConstants.contentTypeHeader: ApiConstants.applicationJson,
    if (_token != null)
      ApiConstants.authorizationHeader: '${ApiConstants.bearerPrefix}$_token',
  };

  // Méthode générique pour les appels GET
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: _defaultHeaders,
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception(AppConstants.erreurReseau);
    } catch (e) {
      throw Exception('Erreur lors de la requête GET: $e');
    }
  }

  // Méthode générique pour les appels POST
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic>? body,
  ) async {
    try {
      // Filtrer les valeurs null du body avant l'envoi
      Map<String, dynamic>? cleanBody;
      if (body != null) {
        cleanBody = _removeNullValues(body);
      }

      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: _defaultHeaders,
        body: cleanBody != null ? jsonEncode(cleanBody) : null,
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception(AppConstants.erreurReseau);
    } catch (e) {
      throw Exception('Erreur lors de la requête POST: $e');
    }
  }

  // Méthode générique pour les appels PUT
  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic>? body,
  ) async {
    try {
      // Filtrer les valeurs null du body avant l'envoi
      Map<String, dynamic>? cleanBody;
      if (body != null) {
        cleanBody = _removeNullValues(body);
      }

      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: _defaultHeaders,
        body: cleanBody != null ? jsonEncode(cleanBody) : null,
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception(AppConstants.erreurReseau);
    } catch (e) {
      throw Exception('Erreur lors de la requête PUT: $e');
    }
  }

  // Méthode générique pour les appels DELETE
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: _defaultHeaders,
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception(AppConstants.erreurReseau);
    } catch (e) {
      throw Exception('Erreur lors de la requête DELETE: $e');
    }
  }

  // Méthode pour supprimer les valeurs null d'un Map
  Map<String, dynamic> _removeNullValues(Map<String, dynamic> map) {
    final Map<String, dynamic> cleanMap = {};

    for (final entry in map.entries) {
      if (entry.value != null) {
        if (entry.value is Map<String, dynamic>) {
          // Récursion pour les Maps imbriqués
          final cleanNestedMap = _removeNullValues(
            entry.value as Map<String, dynamic>,
          );
          if (cleanNestedMap.isNotEmpty) {
            cleanMap[entry.key] = cleanNestedMap;
          }
        } else if (entry.value is List) {
          // Gérer les listes
          final cleanList = (entry.value as List)
              .where((item) => item != null)
              .map((item) {
                if (item is Map<String, dynamic>) {
                  return _removeNullValues(item);
                }
                return item;
              })
              .toList();
          if (cleanList.isNotEmpty) {
            cleanMap[entry.key] = cleanList;
          }
        } else {
          cleanMap[entry.key] = entry.value;
        }
      }
    }

    return cleanMap;
  }

  // Gestion des réponses HTTP
  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;

    // Tenter de parser le JSON
    Map<String, dynamic> jsonResponse;
    try {
      final decoded = jsonDecode(body);
      jsonResponse = decoded is Map<String, dynamic>
          ? decoded
          : {'message': body};
    } catch (e) {
      // Si ce n'est pas du JSON, créer une réponse simple
      jsonResponse = {'message': body};
    }

    switch (statusCode) {
      case 200:
      case 201:
        return jsonResponse;

      case 400:
        throw ApiException(
          message:
              (jsonResponse['message'] as String?) ??
              AppConstants.erreurDonnees,
          statusCode: statusCode,
        );

      case 401:
        // Token invalide ou expiré
        _token = null;
        throw ApiException(
          message:
              (jsonResponse['message'] as String?) ??
              AppConstants.erreurAuthentification,
          statusCode: statusCode,
        );

      case 403:
        throw ApiException(
          message:
              (jsonResponse['message'] as String?) ??
              AppConstants.erreurAutorisation,
          statusCode: statusCode,
        );

      case 404:
        throw ApiException(
          message:
              (jsonResponse['message'] as String?) ?? 'Ressource non trouvée',
          statusCode: statusCode,
        );

      case 500:
        throw ApiException(
          message:
              (jsonResponse['message'] as String?) ??
              AppConstants.erreurServeur,
          statusCode: statusCode,
        );

      default:
        throw ApiException(
          message:
              (jsonResponse['message'] as String?) ??
              AppConstants.erreurInconnue,
          statusCode: statusCode,
        );
    }
  }
}

// Exception personnalisée pour les erreurs API
class ApiException implements Exception {
  final String message;
  final int statusCode;

  const ApiException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() => 'ApiException($statusCode): $message';
}
