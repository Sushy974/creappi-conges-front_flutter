import 'package:creappi_conge/repositories/demandes_repository.dart';

class SoumettreDemandeDeCongeUsecase {
  SoumettreDemandeDeCongeUsecase({
    required DemandesRepository demandesRepository,
  }) : _demandesRepository = demandesRepository;

  final DemandesRepository _demandesRepository;

  Future<void> execute(SoumettreDemandeDeCongeCommand command) async {
    print('command : ${command.dateDebut} ${command.dateFin} ${command.motif}');
    await _demandesRepository.soumettreDemandeDeConge(
      token: command.token,
      dateDebut: command.dateDebut,
      dateFin: command.dateFin,
      motif: command.motif,
    );
  }
}

class SoumettreDemandeDeCongeCommand {
  SoumettreDemandeDeCongeCommand({
    required this.token,
    required this.dateDebut,
    required this.dateFin,
    required this.motif,
  });

  final String token;
  final String dateDebut;
  final String dateFin;
  final String motif;
}
