part of 'dashboard_employe_bloc.dart';

const limitDemandesDeConges = 5;

class DashboardEmployeState extends Equatable {
  const DashboardEmployeState({
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage = '',
    this.demandesDeConges = const [],
    this.regarderTouteLesDemandes = false,
  });

  final FormzSubmissionStatus status;
  final String errorMessage;
  final List<DemandeConge> demandesDeConges;
  final bool regarderTouteLesDemandes;

  int get longueurListeDemandes => regarderTouteLesDemandes
      ? demandesDeConges.length
      : limitDemandesDeConges;

  DashboardEmployeState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    List<DemandeConge>? demandesDeConges,
    bool? regarderTouteLesDemandes,
  }) {
    return DashboardEmployeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      demandesDeConges: demandesDeConges ?? this.demandesDeConges,
      regarderTouteLesDemandes:
          regarderTouteLesDemandes ?? this.regarderTouteLesDemandes,
    );
  }

  @override
  List<Object?> get props => [
    status,
    demandesDeConges,
    regarderTouteLesDemandes,
    errorMessage,
  ];
}
