class Utilisateur {
  const Utilisateur({
    required this.id,
    required this.email,
    required this.motDePasseHash,
    required this.role,
    required this.actif,
    this.employe,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'] as String,
      email: json['email'] as String,
      motDePasseHash: json['mot_de_passe_hash'] as String? ?? '',
      role: json['role'] as String,
      actif: json['actif'] as bool? ?? true,
      employe: json['employe'] != null
          ? Employe.fromJson(json['employe'] as Map<String, dynamic>)
          : null,
    );
  }
  final String id;
  final String email;
  final String motDePasseHash;
  final String role;
  final bool actif;
  final Employe? employe;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'email': email,
      'mot_de_passe_hash': motDePasseHash,
      'role': role,
      'actif': actif,
    };

    // Ne pas inclure employe s'il est null
    if (employe != null) {
      data['employe'] = employe!.toJson();
    }

    return data;
  }

  Utilisateur copyWith({
    String? id,
    String? email,
    String? motDePasseHash,
    String? role,
    bool? actif,
    Employe? employe,
  }) {
    return Utilisateur(
      id: id ?? this.id,
      email: email ?? this.email,
      motDePasseHash: motDePasseHash ?? this.motDePasseHash,
      role: role ?? this.role,
      actif: actif ?? this.actif,
      employe: employe ?? this.employe,
    );
  }

  @override
  String toString() {
    return 'Utilisateur(id: $id, email: $email, role: $role, actif: $actif)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Utilisateur && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Employe {
  const Employe({
    required this.id,
    required this.prenom,
    required this.nom,
    required this.dateEmbauche,
  });
  factory Employe.fromJson(Map<String, dynamic> json) {
    return Employe(
      id: json['id'] as String,
      prenom: json['prenom'] as String,
      nom: json['nom'] as String,
      dateEmbauche: json['date_embauche'] as String,
    );
  }
  final String id;
  final String prenom;
  final String nom;
  final String dateEmbauche;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prenom': prenom,
      'nom': nom,
      'date_embauche': dateEmbauche,
    };
  }

  Employe copyWith({
    String? id,
    String? prenom,
    String? nom,
    String? dateEmbauche,
    Utilisateur? utilisateur,
  }) {
    return Employe(
      id: id ?? this.id,
      prenom: prenom ?? this.prenom,
      nom: nom ?? this.nom,
      dateEmbauche: dateEmbauche ?? this.dateEmbauche,
    );
  }

  String get nomComplet => '$prenom $nom';

  @override
  String toString() {
    return 'Employe(id: $id, nomComplet: $nomComplet, dateEmbauche: $dateEmbauche)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Employe && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
