import 'utilisateur.dart';

class DemandeConge {
  const DemandeConge({
    required this.id,
    required this.dateDemande,
    required this.employe,
    required this.dateDebut,
    required this.dateFin,
    required this.nbJours,
    required this.statut,
    this.motif,
    this.validePar,
    this.dateValidation,
  });

  factory DemandeConge.fromJson(Map<String, dynamic> json) {
    return DemandeConge(
      id: json['id'] as String,
      dateDemande: json['dateDemande'] as String,
      employe: Employe.fromJson(json['employe'] as Map<String, dynamic>),
      dateDebut: json['date_debut'] as String,
      dateFin: json['date_fin'] as String,
      nbJours: json['nb_jours'] as String,
      statut: StatutDemandeConge.fromName(json['statut'] as String),
      motif: json['motif'] as String?,
      validePar: json['valide_par'] as String?,
      dateValidation: json['date_validation'] != null
          ? DateTime.parse(json['date_validation'] as String)
          : null,
    );
  }
  final String id;
  final String dateDemande;
  final Employe employe;
  final String dateDebut;
  final String dateFin;
  final String nbJours;
  final StatutDemandeConge statut;
  final String? motif;
  final String? validePar;
  final DateTime? dateValidation;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'employe': employe.toJson(),
      'date_debut': dateDebut,
      'date_fin': dateFin,
      'nb_jours': nbJours,
      'dateDemande': dateDemande,
      'statut': statut,
    };

    // Ne pas inclure les champs optionnels s'ils sont null
    if (motif != null) {
      data['motif'] = motif;
    }
    if (validePar != null) {
      data['valide_par'] = validePar;
    }
    if (dateValidation != null) {
      data['date_validation'] = dateValidation!.toIso8601String();
    }

    return data;
  }

  DemandeConge copyWith({
    String? id,
    String? dateDemande,
    Employe? employe,
    String? dateDebut,
    String? dateFin,
    String? nbJours,
    StatutDemandeConge? statut,
    String? motif,
    String? validePar,
    DateTime? dateValidation,
  }) {
    return DemandeConge(
      id: id ?? this.id,
      dateDemande: dateDemande ?? this.dateDemande,
      employe: employe ?? this.employe,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFin: dateFin ?? this.dateFin,
      nbJours: nbJours ?? this.nbJours,
      statut: statut ?? this.statut,
      motif: motif ?? this.motif,
      validePar: validePar ?? this.validePar,
      dateValidation: dateValidation ?? this.dateValidation,
    );
  }

  // Getters pour faciliter l'utilisation
  bool get estDepose => statut == StatutDemandeConge.depose;
  bool get estValide => statut == StatutDemandeConge.valide;
  bool get estRefuse => statut == StatutDemandeConge.refuse;

  String get statutLibelle {
    switch (statut) {
      case StatutDemandeConge.depose:
        return 'Déposée';
      case StatutDemandeConge.valide:
        return 'Validée';
      case StatutDemandeConge.refuse:
        return 'Refusée';
    }
  }

  DateTime get dateDebutDateTime => DateTime.parse(dateDebut);
  DateTime get dateFinDateTime => DateTime.parse(dateFin);

  @override
  String toString() {
    return 'DemandeConge(id: $id, employe: ${employe.nomComplet}, '
        'dates: $dateDebut -> $dateFin, statut: $statut)';
  }
}

enum StatutDemandeConge {
  depose(),
  valide(),
  refuse();

  String get name => switch (this) {
    depose => 'depose',
    valide => 'valide',
    refuse => 'refuse',
  };

  static StatutDemandeConge fromName(String name) {
    print('name : $name');
    switch (name) {
      case 'depose':
        return StatutDemandeConge.depose;
      case 'valide':
        return StatutDemandeConge.valide;
      case 'refuse':
        return StatutDemandeConge.refuse;
      default:
        throw Exception('StatutDemandeConge inconnu: $name');
    }
  }
}

// Modèles pour les requêtes
class DemandeCongeRequest {
  const DemandeCongeRequest({
    required this.dateDebut,
    required this.dateFin,
    this.motif,
  });
  final String dateDebut;
  final String dateFin;
  final String? motif;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'date_debut': dateDebut,
      'date_fin': dateFin,
    };

    // Ne pas inclure motif s'il est null
    if (motif != null) {
      data['motif'] = motif;
    }

    return data;
  }
}

class ValidationDemandeRequest {
  const ValidationDemandeRequest({
    required this.statut,
    this.motifDecision,
  });
  final String statut;
  final String? motifDecision;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'statut': statut,
    };

    // Ne pas inclure motif_decision s'il est null
    if (motifDecision != null) {
      data['motif_decision'] = motifDecision;
    }

    return data;
  }
}
