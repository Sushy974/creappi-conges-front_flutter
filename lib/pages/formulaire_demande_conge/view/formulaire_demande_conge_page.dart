import 'package:creappi_conge/app/bloc/app_bloc.dart';
import 'package:creappi_conge/pages/formulaire_demande_conge/bloc/formulaire_demande_conge_bloc.dart';
import 'package:creappi_conge/pages/formulaire_demande_conge/view/formulaire_demande_conge_view.dart';
import 'package:creappi_conge/repositories/demandes_repository.dart';
import 'package:creappi_conge/usecases/soumettre_demande_de_conge_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormulaireDemandeCongePage extends StatelessWidget {
  const FormulaireDemandeCongePage({
    required this.token,
    super.key,
  });

  final String token;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormulaireDemandeCongeBloc(
        token: token,
        soumettreDemandeDeCongeUsecase: SoumettreDemandeDeCongeUsecase(
          demandesRepository: context.read<DemandesRepository>(),
        ),
      ),
      child: const FormulaireDemandeCongeView(),
    );
  }
}
