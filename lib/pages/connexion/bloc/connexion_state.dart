part of 'connexion_bloc.dart';

class ConnexionState extends Equatable {
  const ConnexionState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const EmailInput.pure(),
    this.motDePasse = const MotDePasseInput.pure(),
    this.errorMessage = '',
    this.token = '',
    this.utilisateur,
  });

  final FormzSubmissionStatus status;
  final EmailInput email;
  final MotDePasseInput motDePasse;
  final String errorMessage;
  final String token;
  final Utilisateur? utilisateur;
  ConnexionState copyWith({
    FormzSubmissionStatus? status,
    EmailInput? email,
    MotDePasseInput? motDePasse,
    String? errorMessage,
    String? token,
    Utilisateur? utilisateur,
  }) {
    return ConnexionState(
      status: status ?? FormzSubmissionStatus.initial,
      email: email ?? this.email,
      motDePasse: motDePasse ?? this.motDePasse,
      errorMessage: errorMessage ?? this.errorMessage,
      token: token ?? this.token,
      utilisateur: utilisateur ?? this.utilisateur,
    );
  }

  @override
  List<Object?> get props => [
    status,
    email,
    motDePasse,
    errorMessage,
    token,
    utilisateur,
  ];
}
