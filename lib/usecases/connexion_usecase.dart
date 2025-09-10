import 'package:creappi_conge/repositories/auth_repository.dart';

class ConnexionUsecase {
  ConnexionUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<AuthResponse> execute(ConnexionCommand command) async {
    final response = await _authRepository.connexion(
      email: command.email,
      motDePasse: command.motDePasse,
    );
    return response;
  }
}

class ConnexionCommand {
  ConnexionCommand({
    required this.email,
    required this.motDePasse,
  });

  final String email;
  final String motDePasse;
}
