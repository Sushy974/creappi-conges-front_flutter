import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/utilisateur.dart';
import '../repositories/auth_repository.dart';
import '../utils/constants.dart';

class AuthService {
  factory AuthService() => _instance;
  AuthService._internal();
  static final AuthService _instance = AuthService._internal();

  final AuthRepository _authRepository = AuthRepository();
  Utilisateur? _utilisateurConnecte;
  String? _token;

  /// Initialise le service d'authentification
  Future<void> initialiser() async {
    await _chargerTokenDepuisStockage();
    if (_token != null) {
      _authRepository.setToken(_token);
    }
  }

  /// Initialise le premier administrateur
  Future<AuthResponse> initialiserAdmin({
    required String email,
    required String motDePasse,
    required String nom,
    required String prenom,
  }) async {
    final response = await _authRepository.initialiserAdmin(
      email: email,
      motDePasse: motDePasse,
      nom: nom,
      prenom: prenom,
    );

    await _sauvegarderSession(response);
    return response;
  }

  /// Connexion d'un utilisateur
  Future<AuthResponse> connexion({
    required String email,
    required String motDePasse,
  }) async {
    final response = await _authRepository.connexion(
      email: email,
      motDePasse: motDePasse,
    );

    await _sauvegarderSession(response);
    return response;
  }

  /// Inscription d'un employé (Admin seulement)
  Future<AuthResponse> inscrireEmploye({
    required String email,
    required String motDePasse,
    required String nom,
    required String prenom,
  }) async {
    final response = await _authRepository.inscrireEmploye(
      email: email,
      motDePasse: motDePasse,
      nom: nom,
      prenom: prenom,
    );

    // Pour l'inscription d'employé, on ne change pas la session de l'admin
    return response;
  }

  /// Déconnexion
  Future<void> deconnexion() async {
    await _authRepository.deconnexion();
    await _supprimerSession();
  }

  /// Vérifie si l'utilisateur est connecté
  bool get estConnecte => _token != null && _utilisateurConnecte != null;

  /// Récupère l'utilisateur connecté
  Utilisateur? get utilisateurConnecte => _utilisateurConnecte;

  /// Récupère le token
  String? get token => _token;

  /// Vérifie si l'utilisateur est admin
  bool get estAdmin => _utilisateurConnecte?.role == ApiConstants.roleAdmin;

  /// Vérifie si l'utilisateur est employé
  bool get estEmploye => _utilisateurConnecte?.role == ApiConstants.roleEmploye;

  /// Sauvegarde la session utilisateur
  Future<void> _sauvegarderSession(AuthResponse response) async {
    final prefs = await SharedPreferences.getInstance();

    _token = response.token;
    _utilisateurConnecte = response.utilisateur;

    if (_token != null) {
      await prefs.setString(StorageKeys.tokenJwt, _token!);
    }

    if (_utilisateurConnecte != null) {
      await prefs.setString(
        StorageKeys.utilisateurConnecte,
        jsonEncode(_utilisateurConnecte!.toJson()),
      );
    }

    await prefs.setString(
      StorageKeys.derniereConnexion,
      DateTime.now().toIso8601String(),
    );
  }

  /// Charge le token depuis le stockage local
  Future<void> _chargerTokenDepuisStockage() async {
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString(StorageKeys.tokenJwt);

    final utilisateurJson = prefs.getString(StorageKeys.utilisateurConnecte);
    if (utilisateurJson != null) {
      try {
        final utilisateurData =
            jsonDecode(utilisateurJson) as Map<String, dynamic>;
        _utilisateurConnecte = Utilisateur.fromJson(utilisateurData);
      } catch (e) {
        // En cas d'erreur de parsing, on supprime les données corrompues
        await _supprimerSession();
      }
    }
  }

  /// Supprime la session utilisateur
  Future<void> _supprimerSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(StorageKeys.tokenJwt);
    await prefs.remove(StorageKeys.utilisateurConnecte);
    await prefs.remove(StorageKeys.derniereConnexion);

    _token = null;
    _utilisateurConnecte = null;
  }

  /// Vérifie si le token est expiré
  Future<bool> get tokenExpire async {
    if (_token == null) return true;

    final prefs = await SharedPreferences.getInstance();
    final derniereConnexionStr = prefs.getString(StorageKeys.derniereConnexion);
    if (derniereConnexionStr == null) return true;

    try {
      final derniereConnexion = DateTime.parse(derniereConnexionStr);
      final maintenant = DateTime.now();
      final difference = maintenant.difference(derniereConnexion);

      return difference > ApiConstants.tokenExpiration;
    } catch (e) {
      return true;
    }
  }

  /// Rafraîchit la session si nécessaire
  Future<void> rafraichirSession() async {
    if (await tokenExpire) {
      await deconnexion();
    }
  }
}
