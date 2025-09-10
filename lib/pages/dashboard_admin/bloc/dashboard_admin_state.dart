part of 'dashboard_admin_bloc.dart';

class DashboardAdminState extends Equatable {
  const DashboardAdminState({
    this.demandesDeConges = const [],
    this.status = FormzSubmissionStatus.initial,
  });

  final List<DemandeConge> demandesDeConges;
  final FormzSubmissionStatus status;

  DashboardAdminState copyWith({
    List<DemandeConge>? demandesDeConges,
    FormzSubmissionStatus? status,
  }) {
    return DashboardAdminState(
      demandesDeConges: demandesDeConges ?? this.demandesDeConges,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [demandesDeConges, status];
}
