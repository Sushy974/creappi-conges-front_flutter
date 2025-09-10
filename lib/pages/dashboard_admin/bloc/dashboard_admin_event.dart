part of 'dashboard_admin_bloc.dart';

abstract class DashboardAdminEvent extends Equatable {
  const DashboardAdminEvent();

  @override
  List<Object?> get props => [];
}

final class DashboardAdminRecupereDemandesDeConges extends DashboardAdminEvent {
  const DashboardAdminRecupereDemandesDeConges();
}
