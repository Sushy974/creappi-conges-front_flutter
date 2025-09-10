import 'package:bloc/bloc.dart';
import 'package:creappi_conge/inputs/date_input.dart';
import 'package:creappi_conge/inputs/text_input.dart';
import 'package:creappi_conge/usecases/soumettre_demande_de_conge_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'formulaire_demande_conge_event.dart';
part 'formulaire_demande_conge_state.dart';

class FormulaireDemandeCongeBloc
    extends Bloc<FormulaireDemandeCongeEvent, FormulaireDemandeCongeState>
    with FormzMixin {
  FormulaireDemandeCongeBloc({
    required String token,
    required SoumettreDemandeDeCongeUsecase soumettreDemandeDeCongeUsecase,
  }) : _soumettreDemandeDeCongeUsecase = soumettreDemandeDeCongeUsecase,
       super(
         FormulaireDemandeCongeState(
           token: token,
         ),
       ) {
    on<FormulaireDemandeCongeDateDebutChanged>(_onDateDebutChanged);
    on<FormulaireDemandeCongeDateFinChanged>(_onDateFinChanged);
    on<FormulaireDemandeCongeMotifChanged>(_onMotifChanged);
    on<FormulaireDemandeCongeSoumettre>(_onSoumettre);
  }

  final SoumettreDemandeDeCongeUsecase _soumettreDemandeDeCongeUsecase;

  void _onDateDebutChanged(
    FormulaireDemandeCongeDateDebutChanged event,
    Emitter<FormulaireDemandeCongeState> emit,
  ) {
    emit(state.copyWith(dateDebut: DateInput.dirty(event.dateDebut)));
  }

  void _onDateFinChanged(
    FormulaireDemandeCongeDateFinChanged event,
    Emitter<FormulaireDemandeCongeState> emit,
  ) {
    emit(state.copyWith(dateFin: DateInput.dirty(event.dateFin)));
  }

  void _onMotifChanged(
    FormulaireDemandeCongeMotifChanged event,
    Emitter<FormulaireDemandeCongeState> emit,
  ) {
    emit(state.copyWith(motif: TextInput.dirty(event.motif)));
  }

  Future<void> _onSoumettre(
    FormulaireDemandeCongeSoumettre event,
    Emitter<FormulaireDemandeCongeState> emit,
  ) async {
    if (isNotValid) return;
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      await _soumettreDemandeDeCongeUsecase.execute(
        SoumettreDemandeDeCongeCommand(
          token: state.token,
          dateDebut: dateTimeToDateServeur(state.dateDebut.value!),
          dateFin: dateTimeToDateServeur(state.dateFin.value!),
          motif: state.motif.value,
        ),
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  String dateTimeToDateServeur(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [
    state.dateDebut,
    state.dateFin,
    state.motif,
  ];
}
