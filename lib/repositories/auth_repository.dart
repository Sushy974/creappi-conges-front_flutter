// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import 'package:creappi_conge/models/utilisateur.dart';
import 'package:creappi_conge/services/api_service.dart';
import 'package:creappi_conge/utils/constants.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  /// Configure le token pour les appels API
  void setToken(String? token) {
    _apiService.setToken(token);
  }

  /// Initialise le premier administrateur
  /// Utilise la clé API spéciale pour créer le premier admin
  Future<AuthResponse> initialiserAdmin({
    required String email,
    required String motDePasse,
    required String nom,
    required String prenom,
  }) async {
    try {
      final requestBody = {
        'email': email,
        'mot_de_passe': motDePasse,
        'nom': nom,
        'prenom': prenom,
        'api_key': ApiConstants.apiKey,
      };

      const requestUrl = 'http://localhost:3000/api/v1/auth/initialize';
      final uri = Uri.parse(requestUrl);

      final request = Request('POST', uri)
        ..headers['Content-Type'] = 'application/json'
        ..bodyBytes = utf8.encode(jsonEncode(requestBody));

      final response = await Response.fromStream(await Client().send(request));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final token = data['jeton_acces'] as String;
        _apiService.setToken(token);

        // Créer l'objet utilisateur à partir de la réponse
        final userData = data['user'] as Map<String, dynamic>;
        final utilisateur = Utilisateur.fromJson(userData);

        return AuthResponse(
          token: token,
          utilisateur: utilisateur,
          message: data['message'] as String? ?? AppConstants.connexionReussie,
        );
      } else {
        throw Exception(
          "Erreur lors de l'initialisation: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Connexion d'un utilisateur existant
  Future<AuthResponse> connexion({
    required String email,
    required String motDePasse,
  }) async {
    try {
      // Requête HTTP directe
      final requestBody = {
        'email': email,
        'mot_de_passe': motDePasse,
      };

      // Essayer différentes URLs
      const requestUrl = 'http://localhost:3000/api/v1/auth/connexion';
      //const requestUrl = 'https://httpbin.org/anything';
      final uri = Uri.parse(requestUrl);

      final request = Request('POST', uri)
        ..headers['Content-Type'] = 'application/json'
        ..bodyBytes = utf8.encode(jsonEncode(requestBody));

      final response = await Response.fromStream(await Client().send(request));

      if (response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final token = data['jeton_acces'] as String;

        final utilisateur = await recupererUtilisateurConnecte(
          connexionToken: token,
        );

        return AuthResponse(
          utilisateur: utilisateur,
          token: token,
          message: AppConstants.connexionReussie,
        );
      } else {
        throw Exception(
          'Erreur lors de la connexion: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Récupère les informations de l'utilisateur connecté via /auth/me
  Future<Utilisateur> recupererUtilisateurConnecte({
    required String connexionToken,
  }) async {
    try {
      const requestUrl = 'http://localhost:3000/api/v1/auth/me';
      final uri = Uri.parse(requestUrl);

      final request = Request('GET', uri)
        ..headers['Authorization'] = 'Bearer $connexionToken'
        ..headers['Content-Type'] = 'application/json';

      final response = await Response.fromStream(await Client().send(request));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Créer l'objet utilisateur à partir de la réponse
        final utilisateur = Utilisateur.fromJson(data as Map<String, dynamic>);

        return utilisateur;
      } else if (response.statusCode == 401) {
        throw const AuthException(
          message: 'Token invalide ou expiré',
          type: AuthErrorType.identifiantsIncorrects,
        );
      } else {
        throw Exception(
          "Erreur lors de la récupération de l'utilisateur: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw _handleAuthError(e);
    }
  }

  /// Inscription d'un nouvel employé (Admin seulement)
  Future<AuthResponse> inscrireEmploye({
    required String email,
    required String motDePasse,
    required String nom,
    required String prenom,
  }) async {
    try {
      final token = _apiService.token;
      if (token == null) {
        throw const AuthException(
          message: 'Aucun token disponible. Veuillez vous connecter.',
          type: AuthErrorType.accesRefuse,
        );
      }

      final requestBody = {
        'email': email,
        'mot_de_passe': motDePasse,
        'nom': nom,
        'prenom': prenom,
      };

      const requestUrl =
          'http://localhost:3000/api/v1/auth/inscription-employe';
      final uri = Uri.parse(requestUrl);

      final request = Request('POST', uri)
        ..headers['Content-Type'] = 'application/json'
        ..headers['Authorization'] = 'Bearer $token'
        ..bodyBytes = utf8.encode(jsonEncode(requestBody));

      final response = await Response.fromStream(await Client().send(request));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        // Créer l'objet utilisateur à partir de la réponse
        final userData = data['user'] as Map<String, dynamic>;
        final utilisateur = Utilisateur.fromJson(userData);

        return AuthResponse(
          token: token, // Garde le token de l'admin
          utilisateur: utilisateur,
          message:
              data['message'] as String? ?? AppConstants.inscriptionReussie,
        );
      } else {
        throw Exception(
          "Erreur lors de l'inscription: ${response.statusCode} - "
          '${response.body}',
        );
      }
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw _handleAuthError(e);
    }
  }

  /// Déconnexion de l'utilisateur
  Future<void> deconnexion() async {
    _apiService.setToken(null);
  }

  /// Vérifie si l'utilisateur est connecté
  bool get estConnecte => _apiService.token != null;

  /// Récupère le token actuel
  String? get token => _apiService.token;

  /// Vérifie si l'utilisateur actuel est admin
  bool get estAdmin {
    // Cette méthode nécessiterait de stocker les infos utilisateur
    // ou de faire un appel API pour vérifier le rôle
    // Pour l'instant, on retourne false par défaut
    return false;
  }

  /// Gestion des erreurs d'authentification
  Exception _handleAuthError(dynamic error) {
    log(error.toString());
    if (error is ApiException) {
      switch (error.statusCode) {
        case 400:
          return AuthException(
            message: error.message,
            type: AuthErrorType.donneesInvalides,
          );
        case 401:
          return AuthException(
            message: error.message,
            type: AuthErrorType.identifiantsIncorrects,
          );
        case 403:
          return AuthException(
            message: error.message,
            type: AuthErrorType.accesRefuse,
          );
        default:
          return AuthException(
            message: error.message,
            type: AuthErrorType.erreurServeur,
          );
      }
    }

    return AuthException(
      message: error.toString(),
      type: AuthErrorType.erreurInconnue,
    );
  }
}

/// Réponse d'authentification
class AuthResponse extends Equatable {
  const AuthResponse({
    required this.token,
    required this.message,
    this.utilisateur,
  });
  final String token;
  final Utilisateur? utilisateur;
  final String message;

  @override
  List<Object?> get props => [
    token,
    utilisateur,
    message,
  ];
}

/// Exception d'authentification
class AuthException implements Exception {
  final String message;
  final AuthErrorType type;

  const AuthException({
    required this.message,
    required this.type,
  });

  @override
  String toString() => 'AuthException($type): $message';
}

/// Types d'erreurs d'authentification
enum AuthErrorType {
  donneesInvalides,
  identifiantsIncorrects,
  accesRefuse,
  erreurServeur,
  erreurInconnue,
}
