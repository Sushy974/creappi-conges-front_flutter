import 'package:bloc/bloc.dart';
import 'package:creappi_conge/models/demande_conge.dart';
import 'package:creappi_conge/usecases/recupere_liste_demande_conges_admin_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'dashboard_admin_event.dart';
part 'dashboard_admin_state.dart';

class DashboardAdminBloc
    extends Bloc<DashboardAdminEvent, DashboardAdminState> {
  DashboardAdminBloc({
    required RecupereListeDemandeCongesEmployeUsecase
    recupereListeDemandeCongesEmployeUsecase,
  }) : _recupereListeDemandeCongesEmployeUsecase =
           recupereListeDemandeCongesEmployeUsecase,
       super(const DashboardAdminState()) {
    on<DashboardAdminRecupereDemandesDeConges>(
      _onDashboardAdminRecupereDemandesDeConges,
    );
  }

  final RecupereListeDemandeCongesEmployeUsecase
  _recupereListeDemandeCongesEmployeUsecase;

  Future<void> _onDashboardAdminRecupereDemandesDeConges(
    DashboardAdminRecupereDemandesDeConges event,
    Emitter<DashboardAdminState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final demandesDeConges = await _recupereListeDemandeCongesEmployeUsecase
        .execute();

    emit(
      state.copyWith(
        demandesDeConges: demandesDeConges,
        status: FormzSubmissionStatus.success,
      ),
    );
  }
}
