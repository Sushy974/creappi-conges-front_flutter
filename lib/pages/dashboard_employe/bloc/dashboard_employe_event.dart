part of 'dashboard_employe_bloc.dart';

abstract class DashboardEmployeEvent extends Equatable {
  const DashboardEmployeEvent();

  @override
  List<Object?> get props => [];
}

final class DashboardEmployeRecupereDemandesDeConges
    extends DashboardEmployeEvent {
  const DashboardEmployeRecupereDemandesDeConges();
}

final class DashboardEmployeRegarderTouteLesDemandes
    extends DashboardEmployeEvent {
  const DashboardEmployeRegarderTouteLesDemandes();
}
