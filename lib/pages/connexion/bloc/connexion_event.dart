part of 'connexion_bloc.dart';

abstract class ConnexionEvent extends Equatable {
  const ConnexionEvent();

  @override
  List<Object?> get props => [];
}

class ConnexionEmailChanged extends ConnexionEvent {
  const ConnexionEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class ConnexionMotDePasseChanged extends ConnexionEvent {
  const ConnexionMotDePasseChanged(this.motDePasse);

  final String motDePasse;

  @override
  List<Object?> get props => [motDePasse];
}

class ConnexionSubmitted extends ConnexionEvent {
  const ConnexionSubmitted();
}

class ConnexionReset extends ConnexionEvent {
  const ConnexionReset();
}
