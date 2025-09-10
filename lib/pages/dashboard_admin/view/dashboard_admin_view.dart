import 'package:creappi_conge/app/bloc/app_bloc.dart';
import 'package:creappi_conge/models/demande_conge.dart';
import 'package:creappi_conge/pages/dashboard_admin/bloc/dashboard_admin_bloc.dart';
import 'package:creappi_conge/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DashboardAdminView extends StatelessWidget {
  const DashboardAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Icons.work,
              size: 24,
              color: AppTheme.textOnPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              'Dashboard Employé',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppTheme.textOnPrimary,
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.textOnPrimary,

        centerTitle: false,
        elevation: 0,
        actions: [
          ElevatedButton(
            child: const Text('Déconnexion'),
            onPressed: () {
              context.read<AppBloc>().add(
                const AppDeconnexion(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardAdminBloc, DashboardAdminState>(
        builder: (context, state) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: TotaleEmploye()),
                    SizedBox(width: 16),
                    Expanded(child: EmployeEnVacances()),
                    SizedBox(width: 16),
                    Expanded(child: EmployePresents()),
                  ],
                ),
                SizedBox(height: 16),
                ListeDesDemandesDeConges(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ListeDesDemandesDeConges extends StatelessWidget {
  const ListeDesDemandesDeConges({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColorFocused,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Demandes de congés',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.tertiary,
              fontSize: 20,
            ),
          ),
          BlocBuilder<DashboardAdminBloc, DashboardAdminState>(
            buildWhen: (previous, current) =>
                previous.demandesDeConges != current.demandesDeConges,
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: state.demandesDeConges.length,
                itemBuilder: (context, index) => DemandeDeCongeWidget(
                  demande: state.demandesDeConges[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DemandeDeCongeWidget extends StatelessWidget {
  const DemandeDeCongeWidget({
    required this.demande,
    super.key,
  });
  final DemandeConge demande;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: AppTheme.backgroundColor,
      //   borderRadius: BorderRadius.circular(16),
      //   border: Border.all(
      //     color: AppTheme.borderColorFocused,
      //     width: 2,
      //   ),
      // ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(demande.employe.nomComplet),
          Text(demande.dateDemande),
          Text(demande.dateDebut),
          Text(demande.dateFin),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class TotaleEmploye extends StatelessWidget {
  const TotaleEmploye({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColorFocused,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total des demandes de congés',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.tertiary,
              fontSize: 20,
            ),
          ),
          Text(
            '250',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeEnVacances extends StatelessWidget {
  const EmployeEnVacances({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColorFocused,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total des employés en vacances',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.tertiary,
              fontSize: 20,
            ),
          ),
          Text(
            '35',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class EmployePresents extends StatelessWidget {
  const EmployePresents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColorFocused,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total des employés présents',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.tertiary,
              fontSize: 20,
            ),
          ),
          Text(
            '215',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
