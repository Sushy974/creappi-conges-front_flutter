import 'package:creappi_conge/app/bloc/app_bloc.dart';
import 'package:creappi_conge/models/demande_conge.dart';
import 'package:creappi_conge/repositories/demandes_repository.dart';

class RecupereListeDemandeCongesEmployeUsecase {
  RecupereListeDemandeCongesEmployeUsecase({
    required DemandesRepository demandesRepository,
    required AppBloc appBloc,
  }) : _demandesRepository = demandesRepository,
       _appBloc = appBloc;

  final DemandesRepository _demandesRepository;
  final AppBloc _appBloc;

  Future<List<DemandeConge>> execute() async {
    final token = _appBloc.state.token;
    if (token == null) {
      throw Exception('Token is null');
    }
    return _demandesRepository.recupererListeDemandeCongesAdmin(
      token: token,
    );
  }
}

class RecupereListeDemandeCongesEmployeCommand {}
