# 📋 API Creappi Congés - Guide d'utilisation

## 🎯 Vue d'ensemble

Cette documentation explique comment utiliser les repositories et services créés pour communiquer avec l'API Creappi Congés.

## 📁 Structure des fichiers

```
lib/
├── models/
│   ├── utilisateur.dart      # Modèles Utilisateur et Employe
│   ├── demande_conge.dart    # Modèle DemandeConge et requêtes
│   └── models.dart          # Export des modèles
├── repositories/
│   ├── auth_repository.dart     # Repository d'authentification
│   ├── demandes_repository.dart # Repository des demandes
│   └── repositories.dart        # Export des repositories
├── services/
│   ├── api_service.dart     # Service HTTP générique
│   ├── auth_service.dart    # Service d'authentification avec persistance
│   └── services.dart        # Export des services
├── utils/
│   └── constants.dart       # Constantes et configuration
└── examples/
    └── api_usage_example.dart # Exemples d'utilisation
```

## 🚀 Démarrage rapide

### 1. Initialisation

```dart
import 'package:creappi_conge/services/services.dart';

// Initialiser le service d'authentification
final authService = AuthService();
await authService.initialiser();
```

### 2. Premier administrateur

```dart
// Créer le premier admin (une seule fois)
final response = await authService.initialiserAdmin(
  email: 'admin@entreprise.com',
  motDePasse: 'admin123456',
  nom: 'Admin',
  prenom: 'Super',
);

print('Token: ${response.token}');
```

### 3. Connexion

```dart
// Se connecter
final response = await authService.connexion(
  email: 'admin@entreprise.com',
  motDePasse: 'admin123456',
);

// Vérifier si connecté
if (authService.estConnecte) {
  print('Utilisateur connecté: ${authService.utilisateurConnecte?.email}');
  print('Rôle: ${authService.utilisateurConnecte?.role}');
}
```

## 👥 Gestion des utilisateurs

### Inscription d'un employé (Admin seulement)

```dart
final response = await authService.inscrireEmploye(
  email: 'employe@entreprise.com',
  motDePasse: 'employe123456',
  nom: 'Dupont',
  prenom: 'Jean',
);
```

### Vérification des rôles

```dart
if (authService.estAdmin) {
  // Actions réservées aux admins
} else if (authService.estEmploye) {
  // Actions pour les employés
}
```

## 📋 Gestion des demandes de congés

### Créer une demande

```dart
import 'package:creappi_conge/repositories/repositories.dart';

final demandesRepo = DemandesRepository();

final demande = await demandesRepo.creerDemande(
  dateDebut: '2024-12-25',
  dateFin: '2024-12-31',
  motif: 'Vacances de Noël',
);

print('Demande créée: ${demande.id}');
print('Statut: ${demande.statutLibelle}');
```

### Lister ses demandes

```dart
final mesDemandes = await demandesRepo.mesDemandes();

for (final demande in mesDemandes) {
  print('${demande.dateDebut} → ${demande.dateFin} '
        '(${demande.nbJours} jours) - ${demande.statutLibelle}');
}
```

### Lister toutes les demandes (Admin)

```dart
final toutesDemandes = await demandesRepo.toutesLesDemandes();

for (final demande in toutesDemandes) {
  print('${demande.employe.nomComplet}: ${demande.statutLibelle}');
}
```

### Valider/Refuser une demande (Admin)

```dart
// Valider
final demandeValidee = await demandesRepo.validerDemande(
  demandeId: 'uuid-de-la-demande',
  statut: 'valide',
  motifDecision: 'Demande approuvée',
);

// Refuser
final demandeRefusee = await demandesRepo.validerDemande(
  demandeId: 'uuid-de-la-demande',
  statut: 'refuse',
  motifDecision: 'Période de forte activité',
);
```

### Statistiques (Admin)

```dart
final stats = await demandesRepo.obtenirStatistiques();

print('Total: ${stats.totalDemandes}');
print('Validées: ${stats.demandesValidees}');
print('Jours validés: ${stats.totalJoursValides}');
```

## 🔧 Gestion des erreurs

### Types d'erreurs d'authentification

```dart
try {
  await authService.connexion(email: email, motDePasse: motDePasse);
} on AuthException catch (e) {
  switch (e.type) {
    case AuthErrorType.identifiantsIncorrects:
      print('Email ou mot de passe incorrect');
      break;
    case AuthErrorType.accesRefuse:
      print('Accès refusé');
      break;
    case AuthErrorType.donneesInvalides:
      print('Données invalides');
      break;
    default:
      print('Erreur: ${e.message}');
  }
}
```

### Types d'erreurs des demandes

```dart
try {
  await demandesRepo.creerDemande(dateDebut: dateDebut, dateFin: dateFin);
} on DemandeException catch (e) {
  switch (e.type) {
    case DemandeErrorType.nonAuthentifie:
      print('Vous devez être connecté');
      break;
    case DemandeErrorType.accesRefuse:
      print('Accès refusé - Admin requis');
      break;
    case DemandeErrorType.donneesInvalides:
      print('Dates invalides');
      break;
    default:
      print('Erreur: ${e.message}');
  }
}
```

## 💾 Persistance des données

Le service d'authentification gère automatiquement la persistance :

- **Token JWT** : Sauvegardé localement
- **Utilisateur connecté** : Informations stockées
- **Dernière connexion** : Pour vérifier l'expiration

```dart
// Vérifier si connecté au démarrage de l'app
await authService.initialiser();

if (authService.estConnecte) {
  // L'utilisateur est déjà connecté
  print('Bienvenue ${authService.utilisateurConnecte?.email}');
} else {
  // Rediriger vers la page de connexion
}
```

## 🔄 Workflow recommandé

1. **Initialisation** : `authService.initialiser()`
2. **Premier admin** : `authService.initialiserAdmin()` (une seule fois)
3. **Connexion** : `authService.connexion()`
4. **Actions métier** : Utiliser les repositories
5. **Déconnexion** : `authService.deconnexion()`

## 📱 Intégration avec Flutter

### Dans un StatefulWidget

```dart
class MonWidget extends StatefulWidget {
  @override
  _MonWidgetState createState() => _MonWidgetState();
}

class _MonWidgetState extends State<MonWidget> {
  final AuthService _authService = AuthService();
  final DemandesRepository _demandesRepo = DemandesRepository();
  
  @override
  void initState() {
    super.initState();
    _initialiser();
  }
  
  Future<void> _initialiser() async {
    await _authService.initialiser();
    if (_authService.estConnecte) {
      _chargerDemandes();
    }
  }
  
  Future<void> _chargerDemandes() async {
    try {
      final demandes = await _demandesRepo.mesDemandes();
      setState(() {
        // Mettre à jour l'UI
      });
    } catch (e) {
      // Gérer l'erreur
    }
  }
}
```

### Avec BLoC/Cubit

```dart
class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();
  
  Future<void> connexion(String email, String motDePasse) async {
    try {
      emit(AuthLoading());
      final response = await _authService.connexion(
        email: email,
        motDePasse: motDePasse,
      );
      emit(AuthSuccess(response.utilisateur!));
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    }
  }
}
```

## ⚠️ Notes importantes

- **Token JWT** : Expire après 24h
- **Dates** : Format ISO 8601 (`YYYY-MM-DD`)
- **UUIDs** : Tous les IDs sont des strings
- **Relations** : Chargées automatiquement par l'API
- **Calculs** : Le nombre de jours est calculé côté serveur

## 🧪 Tests

Voir le fichier `examples/api_usage_example.dart` pour des exemples complets d'utilisation.

```dart
final example = ApiUsageExample();
await example.workflowComplet();
```

Cette structure vous permet d'intégrer facilement l'API Creappi Congés dans votre application Flutter ! 🚀
