part of 'formulaire_demande_conge_bloc.dart';

class FormulaireDemandeCongeState extends Equatable {
  const FormulaireDemandeCongeState({
    required this.token,
    this.dateDebut = const DateInput.pure(),
    this.dateFin = const DateInput.pure(),
    this.motif = const TextInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage = '',
  });

  final String token;
  final DateInput dateDebut;
  final DateInput dateFin;
  final TextInput motif;
  final FormzSubmissionStatus status;
  final String errorMessage;

  FormulaireDemandeCongeState copyWith({
    String? token,
    DateInput? dateDebut,
    DateInput? dateFin,
    TextInput? motif,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return FormulaireDemandeCongeState(
      token: token ?? this.token,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFin: dateFin ?? this.dateFin,
      motif: motif ?? this.motif,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    token,
    dateDebut,
    dateFin,
    motif,
    status,
    errorMessage,
  ];
}
