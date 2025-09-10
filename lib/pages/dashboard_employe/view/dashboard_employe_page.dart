import 'package:creappi_conge/app/bloc/app_bloc.dart';
import 'package:creappi_conge/pages/dashboard_employe/bloc/dashboard_employe_bloc.dart';
import 'package:creappi_conge/pages/dashboard_employe/view/dashboard_employe_view.dart';
import 'package:creappi_conge/repositories/demandes_repository.dart';
import 'package:creappi_conge/usecases/recupere_liste_demande_conges_employe_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardEmployePage extends StatelessWidget {
  const DashboardEmployePage({super.key});

  static Page<DashboardEmployePage> page() {
    return const MaterialPage(child: DashboardEmployePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardEmployeBloc(
            recupereListeDemandeCongesEmployeUsecase:
                RecupereListeDemandeCongesEmployeUsecase(
                  demandesRepository: context.read<DemandesRepository>(),
                  appBloc: context.read<AppBloc>(),
                ),
          )..add(
            const DashboardEmployeRecupereDemandesDeConges(),
          ),
      child: const DashboardEmployeView(),
    );
  }
}
