part of 'app_bloc.dart';

enum ConnexionStatus { initial, loading, success, failure }

class AppState extends Equatable {
  const AppState({
    this.token,
    this.utilisateur,
  });

  final String? token;
  final Utilisateur? utilisateur;

  AppState copyWith({
    String? Function()? token,
    Utilisateur? Function()? utilisateur,
  }) {
    return AppState(
      token: token != null ? token() : this.token,
      utilisateur: utilisateur != null ? utilisateur() : this.utilisateur,
    );
  }

  @override
  List<Object?> get props => [
    token,
    utilisateur,
  ];
}
