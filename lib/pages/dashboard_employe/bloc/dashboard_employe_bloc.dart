import 'package:bloc/bloc.dart';
import 'package:creappi_conge/models/demande_conge.dart';
import 'package:creappi_conge/usecases/recupere_liste_demande_conges_employe_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'dashboard_employe_event.dart';
part 'dashboard_employe_state.dart';

class DashboardEmployeBloc
    extends Bloc<DashboardEmployeEvent, DashboardEmployeState> {
  DashboardEmployeBloc({
    required RecupereListeDemandeCongesEmployeUsecase
    recupereListeDemandeCongesEmployeUsecase,
  }) : _recupereListeDemandeCongesEmployeUsecase =
           recupereListeDemandeCongesEmployeUsecase,
       super(const DashboardEmployeState()) {
    on<DashboardEmployeRecupereDemandesDeConges>(
      _onDashboardEmployeRecupereDemandesDeConges,
    );
    on<DashboardEmployeRegarderTouteLesDemandes>(
      _onDashboardEmployeRegarderTouteLesDemandes,
    );
  }

  final RecupereListeDemandeCongesEmployeUsecase
  _recupereListeDemandeCongesEmployeUsecase;

  Future<void> _onDashboardEmployeRecupereDemandesDeConges(
    DashboardEmployeRecupereDemandesDeConges event,
    Emitter<DashboardEmployeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final demandesDeConges = await _recupereListeDemandeCongesEmployeUsecase
          .execute();

      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          demandesDeConges: demandesDeConges,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage:
              'Erreur lors de la récupération des demandes de congés $e',
        ),
      );
    }
  }

  Future<void> _onDashboardEmployeRegarderTouteLesDemandes(
    DashboardEmployeRegarderTouteLesDemandes event,
    Emitter<DashboardEmployeState> emit,
  ) async {
    emit(
      state.copyWith(
        regarderTouteLesDemandes: !state.regarderTouteLesDemandes,
      ),
    );
  }
}
