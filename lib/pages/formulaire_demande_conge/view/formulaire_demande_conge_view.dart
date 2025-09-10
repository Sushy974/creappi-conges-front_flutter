import 'package:creappi_conge/pages/formulaire_demande_conge/bloc/formulaire_demande_conge_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class FormulaireDemandeCongeView extends StatelessWidget {
  const FormulaireDemandeCongeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<
      FormulaireDemandeCongeBloc,
      FormulaireDemandeCongeState
    >(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.pop(context);
        }
      },
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 800,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text('Formulaire de demande de congé'),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date de début'),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onPrimary,
                              border: Border.all(
                                color: theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(5),
                            child:
                                BlocBuilder<
                                  FormulaireDemandeCongeBloc,
                                  FormulaireDemandeCongeState
                                >(
                                  buildWhen: (previous, current) =>
                                      previous.dateDebut != current.dateDebut,
                                  builder: (context, state) {
                                    return Text(
                                      state.dateDebut.value?.toString() ?? '',
                                    );
                                  },
                                ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final date = await _selectDate(
                              context: context,
                              isDateDebut: true,
                            );
                            if (date == null) return;
                            if (!context.mounted) return;
                            context.read<FormulaireDemandeCongeBloc>().add(
                              FormulaireDemandeCongeDateDebutChanged(date),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date de fin'),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onPrimary,
                              border: Border.all(
                                color: theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(5),
                            child:
                                BlocBuilder<
                                  FormulaireDemandeCongeBloc,
                                  FormulaireDemandeCongeState
                                >(
                                  buildWhen: (previous, current) =>
                                      previous.dateFin != current.dateFin,
                                  builder: (context, state) {
                                    return Text(
                                      state.dateFin.value?.toString() ?? '',
                                    );
                                  },
                                ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final date = await _selectDate(
                              context: context,
                              isDateDebut: true,
                            );
                            if (date == null) return;
                            if (!context.mounted) return;
                            context.read<FormulaireDemandeCongeBloc>().add(
                              FormulaireDemandeCongeDateFinChanged(date),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Motif',
                  ),
                  maxLines: 3,
                  onChanged: (motif) {
                    context.read<FormulaireDemandeCongeBloc>().add(
                      FormulaireDemandeCongeMotifChanged(motif),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      context.read<FormulaireDemandeCongeBloc>().isNotValid
                      ? null
                      : () {
                          context.read<FormulaireDemandeCongeBloc>().add(
                            FormulaireDemandeCongeSoumettre(),
                          );
                        },
                  child: const Text('Soumettre'),
                ),
                Text(
                  context
                      .watch<FormulaireDemandeCongeBloc>()
                      .state
                      .dateDebut
                      .isValid
                      .toString(),
                ),
                Text(
                  context
                      .watch<FormulaireDemandeCongeBloc>()
                      .state
                      .dateFin
                      .isValid
                      .toString(),
                ),
                Text(
                  context
                      .watch<FormulaireDemandeCongeBloc>()
                      .state
                      .motif
                      .isValid
                      .toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectDate({
    required BuildContext context,
    required bool isDateDebut,
  }) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return null;
    if (!context.mounted) return null;
    return date;
  }
}
