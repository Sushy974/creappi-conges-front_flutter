part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppTokenChanged extends AppEvent {
  const AppTokenChanged(this.token);

  final String token;

  @override
  List<Object?> get props => [token];
}

class AppUtilisateurChanged extends AppEvent {
  const AppUtilisateurChanged(this.utilisateur);

  final Utilisateur utilisateur;

  @override
  List<Object?> get props => [utilisateur];
}

class AppDeconnexion extends AppEvent {
  const AppDeconnexion();
}
