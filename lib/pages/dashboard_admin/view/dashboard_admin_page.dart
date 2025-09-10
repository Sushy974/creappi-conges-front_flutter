import 'package:creappi_conge/app/bloc/app_bloc.dart';
import 'package:creappi_conge/pages/dashboard_admin/bloc/dashboard_admin_bloc.dart';
import 'package:creappi_conge/pages/dashboard_admin/view/dashboard_admin_view.dart';
import 'package:creappi_conge/repositories/demandes_repository.dart';
import 'package:creappi_conge/usecases/recupere_liste_demande_conges_admin_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardAdminPage extends StatelessWidget {
  const DashboardAdminPage({super.key});

  static Page<DashboardAdminPage> page() {
    return const MaterialPage(child: DashboardAdminPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardAdminBloc(
            recupereListeDemandeCongesEmployeUsecase:
                RecupereListeDemandeCongesEmployeUsecase(
                  demandesRepository: context.read<DemandesRepository>(),
                  appBloc: context.read<AppBloc>(),
                ),
          )..add(
            const DashboardAdminRecupereDemandesDeConges(),
          ),
      child: const DashboardAdminView(),
    );
  }
}
