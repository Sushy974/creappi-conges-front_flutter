part of 'formulaire_demande_conge_bloc.dart';

abstract class FormulaireDemandeCongeEvent extends Equatable {
  const FormulaireDemandeCongeEvent();

  @override
  List<Object?> get props => [];
}

final class FormulaireDemandeCongeDateDebutChanged
    extends FormulaireDemandeCongeEvent {
  const FormulaireDemandeCongeDateDebutChanged(this.dateDebut);

  final DateTime? dateDebut;

  @override
  List<Object?> get props => [dateDebut];
}

final class FormulaireDemandeCongeDateFinChanged
    extends FormulaireDemandeCongeEvent {
  const FormulaireDemandeCongeDateFinChanged(this.dateFin);

  final DateTime? dateFin;

  @override
  List<Object?> get props => [dateFin];
}

final class FormulaireDemandeCongeMotifChanged
    extends FormulaireDemandeCongeEvent {
  const FormulaireDemandeCongeMotifChanged(this.motif);

  final String motif;

  @override
  List<Object?> get props => [motif];
}

final class FormulaireDemandeCongeSoumettre
    extends FormulaireDemandeCongeEvent {}
