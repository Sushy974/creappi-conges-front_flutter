class ApiConstants {
  // Base URL de l'API
  static const String baseUrl = 'http://localhost:3000/api/v1';

  // Clé API pour l'initialisation du premier admin
  static const String apiKey =
      'MkjY2SzXah5QUE5m9824XNkFR36j7T2p5Dw9V9qW8tBfw8KH4w64i5yi2sU33Kv24t7J5Rg2nSG37gn8z3V8iCK33NNKLA3hAFL7tx962NFKkntuSaV8kynaTzu5';

  // Endpoints d'authentification
  static const String authInitialize = '/auth/initialize';
  static const String authConnexion = '/auth/connexion';
  static const String authInscriptionEmploye = '/auth/inscription-employe';

  // Endpoints des demandes de congés
  static const String congesDemandes = '/conges/demandes';
  static const String meCongesDemandes = '/me/conges/demandes';
  static const String adminCongesDemandes = '/admin/conges/demandes';

  // Headers
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';
  static const String contentTypeHeader = 'Content-Type';
  static const String applicationJson = 'application/json';

  // Durée d'expiration du token JWT (24h)
  static const Duration tokenExpiration = Duration(hours: 24);

  // Statuts des demandes
  static const String statutDepose = 'depose';
  static const String statutValide = 'valide';
  static const String statutRefuse = 'refuse';

  // Rôles utilisateur
  static const String roleAdmin = 'admin';
  static const String roleEmploye = 'employe';
}

class AppConstants {
  // Messages d'erreur
  static const String erreurReseau = 'Erreur de connexion réseau';
  static const String erreurServeur = 'Erreur du serveur';
  static const String erreurAuthentification = 'Erreur d\'authentification';
  static const String erreurAutorisation = 'Accès non autorisé';
  static const String erreurDonnees = 'Données invalides';
  static const String erreurInconnue = 'Une erreur inattendue s\'est produite';

  // Messages de succès
  static const String connexionReussie = 'Connexion réussie';
  static const String inscriptionReussie = 'Inscription réussie';
  static const String demandeCreee = 'Demande de congé créée';
  static const String demandeValidee = 'Demande validée';
  static const String demandeRefusee = 'Demande refusée';

  // Formats de date
  static const String formatDate = 'yyyy-MM-dd';
  static const String formatDateTime = 'yyyy-MM-dd HH:mm:ss';
  static const String formatDateAffichage = 'dd/MM/yyyy';
  static const String formatDateTimeAffichage = 'dd/MM/yyyy HH:mm';
}

class StorageKeys {
  static const String tokenJwt = 'jwt_token';
  static const String utilisateurConnecte = 'utilisateur_connecte';
  static const String derniereConnexion = 'derniere_connexion';
}
