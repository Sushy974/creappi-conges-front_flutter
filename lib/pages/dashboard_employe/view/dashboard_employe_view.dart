import 'package:creappi_conge/app/bloc/app_bloc.dart';
import 'package:creappi_conge/models/demande_conge.dart';
import 'package:creappi_conge/pages/dashboard_employe/bloc/dashboard_employe_bloc.dart';
import 'package:creappi_conge/pages/formulaire_demande_conge/view/formulaire_demande_conge_page.dart';
import 'package:creappi_conge/pages/formulaire_demande_conge/view/formulaire_demande_conge_view.dart';
import 'package:creappi_conge/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardEmployeView extends StatelessWidget {
  const DashboardEmployeView({super.key});

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
      body: BlocBuilder<DashboardEmployeBloc, DashboardEmployeState>(
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(child: JourCumulee()),
                    Expanded(child: Soldes()),
                  ],
                ),
                const DemandesDeCongesListeWidget(),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final token = context.read<AppBloc>().state.token!;
                      showDialog<void>(
                        context: context,
                        builder: (context) => FormulaireDemandeCongePage(
                          token: token,
                        ),
                      );
                    },
                    child: const Text('Créer une demande de congé'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

class JourCumulee extends StatelessWidget {
  const JourCumulee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(16),
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
        children: [
          Row(
            children: [
              const Icon(
                Icons.date_range,
                size: 24,
                color: AppTheme.textPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                'Jour accumulée par mois',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          Text(
            '2.5 jours',
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class Soldes extends StatelessWidget {
  const Soldes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(16),
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
        children: [
          Row(
            children: [
              const Icon(
                Icons.money,
                size: 24,
                color: AppTheme.textPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                'Soldes',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          Text(
            'Il vous reste 15 jours de congés',
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class DemandesDeCongesListeWidget extends StatelessWidget {
  const DemandesDeCongesListeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(16),
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
        children: [
          Row(
            children: [
              const Icon(
                Icons.insert_drive_file,
                size: 24,
                color: AppTheme.textPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                'Vos demandes de congés',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.read<DashboardEmployeBloc>().add(
                    const DashboardEmployeRecupereDemandesDeConges(),
                  );
                },
                color: AppTheme.textPrimary,
                iconSize: 24,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardEmployeBloc>().add(
                const DashboardEmployeRecupereDemandesDeConges(),
              );
            },
            child: BlocBuilder<DashboardEmployeBloc, DashboardEmployeState>(
              buildWhen: (previous, current) =>
                  previous.demandesDeConges != current.demandesDeConges,
              builder: (context, state) {
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: state.demandesDeConges.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return DemandeDeCongeWidget(
                      demande: state.demandesDeConges[index],
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Voir toutes les demandes'),
            onPressed: () {
              context.read<DashboardEmployeBloc>().add(
                const DashboardEmployeRegarderTouteLesDemandes(),
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
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColorFocused,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            switch (demande.statut) {
              StatutDemandeConge.depose => Text(
                'Votre dernière demande de congé a été soumise le ${demande.dateDemande} pour une durée de ${double.parse(demande.nbJours).toInt()} jours. Statut : ${demande.statutLibelle}',
              ),
              // TODO: Handle this case.
              StatutDemandeConge.valide => Text(
                'Votre demande de congé soumise le ${demande.dateDemande} pour ${double.parse(demande.nbJours).toInt()} jours a été ${demande.statutLibelle}.',
              ),
              // TODO: Handle this case.
              StatutDemandeConge.refuse => Text(
                'Votre demande de congé soumise le ${demande.dateDemande} pour ${double.parse(demande.nbJours).toInt()} jours a été ${demande.statutLibelle}.',
              ),
            },
          ],
        ),
      ),
    );
  }
}
