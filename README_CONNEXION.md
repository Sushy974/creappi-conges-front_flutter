# 🔐 Page de Connexion - Créapp-i Congés

## 🎯 Vue d'ensemble

Cette page de connexion a été créée pour correspondre exactement au design fourni dans l'image. Elle utilise un thème personnalisé avec des couleurs turquoise/teal et une interface moderne et épurée.

## 🎨 Design et Thème

### Couleurs principales
- **Couleur principale** : `#20B2AA` (Turquoise/Teal)
- **Couleur principale claire** : `#7FFFD4` (Aquamarine)
- **Couleur principale foncée** : `#008B8B` (Dark Cyan)
- **Fond** : `#FFFFFF` (Blanc)
- **Texte principal** : `#2C3E50` (Bleu-gris foncé)
- **Texte secondaire** : `#7F8C8D` (Gris)

### Caractéristiques visuelles
- ✅ **Carte centrale** avec ombre subtile
- ✅ **Logo** avec icône stylisée (oiseau/feuille)
- ✅ **Champs de saisie** avec bordures arrondies
- ✅ **Bouton de connexion** turquoise avec texte blanc
- ✅ **Design responsive** et moderne

## 🚀 Fonctionnalités

### Authentification avec données statiques
L'application utilise des données statiques pour les tests :

| Email | Mot de passe | Rôle |
|-------|--------------|------|
| `admin@entreprise.com` | `admin123456` | Admin |
| `employe@entreprise.com` | `employe123456` | Employé |
| `test@test.com` | `test123` | Test |

### Validation des champs
- ✅ **Email** : Validation du format email
- ✅ **Mot de passe** : Minimum 6 caractères
- ✅ **Affichage/masquage** du mot de passe
- ✅ **Messages d'erreur** en français

### États de connexion
- 🔄 **Chargement** : Indicateur de progression
- ✅ **Succès** : Message de confirmation
- ❌ **Erreur** : Message d'erreur explicite

## 📱 Utilisation

### 1. Lancer l'application
```bash
flutter run
```

### 2. Tester la connexion
1. **Saisir un email** dans le champ "Nom d'utilisateur"
2. **Saisir un mot de passe** dans le champ "Mot de passe"
3. **Cliquer sur "Connexion"**
4. **Attendre la validation** (2 secondes de simulation)

### 3. Utiliser les comptes de test
- Cliquer sur l'icône 📋 à côté de chaque compte de test
- Les champs se remplissent automatiquement
- Cliquer sur "Connexion" pour tester

## 🏗️ Architecture

### Structure des fichiers
```
lib/
├── pages/connexion/
│   ├── bloc/
│   │   ├── connexion_bloc.dart      # Logique métier
│   │   ├── connexion_event.dart     # Événements
│   │   └── connexion_state.dart     # États
│   └── view/
│       ├── connexion_page.dart      # Page principale
│       └── connexion_view.dart      # Vue de connexion
├── theme/
│   └── app_theme.dart               # Thème personnalisé
├── widgets/
│   └── custom_widgets.dart          # Widgets réutilisables
└── demo/
    └── demo_page.dart               # Page de démonstration
```

### Pattern BLoC
- **Events** : `ConnexionEmailChanged`, `ConnexionMotDePasseChanged`, `ConnexionSubmitted`
- **States** : `ConnexionStatus` (initial, loading, success, failure)
- **Bloc** : Gestion de l'état et de la logique de connexion

## 🎨 Widgets personnalisés

### AppCard
Carte avec ombre personnalisée et coins arrondis.

### AppTextField
Champ de saisie avec label, validation et icônes.

### AppButton
Bouton avec états (normal, loading, secondary) et icônes.

### AppLogo
Logo avec image ou icône de fallback.

### AppLoadingIndicator
Indicateur de chargement avec message optionnel.

### AppErrorMessage
Message d'erreur avec bouton de retry.

## 🔧 Personnalisation

### Modifier les couleurs
Éditer `lib/theme/app_theme.dart` :
```dart
static const Color primaryColor = Color(0xFF20B2AA); // Votre couleur
```

### Ajouter des comptes de test
Modifier `lib/pages/connexion/bloc/connexion_bloc.dart` :
```dart
final utilisateursStatiques = {
  'votre@email.com': 'votre_mot_de_passe',
  // ... autres comptes
};
```

### Changer le logo
Remplacer `assets/images/creapp-i.png` par votre image.

## 📋 Tests

### Comptes de test disponibles
1. **Admin** : `admin@entreprise.com` / `admin123456`
2. **Employé** : `employe@entreprise.com` / `employe123456`
3. **Test** : `test@test.com` / `test123`

### Scénarios de test
- ✅ Connexion avec des identifiants valides
- ❌ Connexion avec des identifiants invalides
- 🔄 Test de l'état de chargement
- 📱 Test de la responsivité

## 🚀 Prochaines étapes

1. **Intégration API** : Remplacer les données statiques par des appels API
2. **Navigation** : Ajouter la navigation vers la page principale après connexion
3. **Persistance** : Sauvegarder la session utilisateur
4. **Sécurité** : Ajouter la validation côté serveur
5. **Tests** : Ajouter des tests unitaires et d'intégration

## 🎯 Résultat

La page de connexion correspond exactement au design fourni avec :
- ✅ Interface moderne et épurée
- ✅ Couleurs turquoise/teal
- ✅ Logo stylisé
- ✅ Champs de saisie avec validation
- ✅ Bouton de connexion avec états
- ✅ Messages d'erreur en français
- ✅ Comptes de test intégrés

L'application est prête à être utilisée et peut être facilement étendue avec de nouvelles fonctionnalités ! 🎉
