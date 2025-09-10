// ignore_for_file: avoid_catches_without_on_clauses

import 'package:bloc/bloc.dart';
import 'package:creappi_conge/models/utilisateur.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppTokenChanged>(_onTokenChanged);
    on<AppUtilisateurChanged>(_onUtilisateurChanged);
    on<AppDeconnexion>(_onDeconnexion);
  }

  void _onTokenChanged(AppTokenChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(token: () => event.token));
  }

  void _onUtilisateurChanged(
    AppUtilisateurChanged event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(utilisateur: () => event.utilisateur));
  }

  void _onDeconnexion(AppDeconnexion event, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        token: () => null,
        utilisateur: () => null,
      ),
    );
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState(
      token: json['token'] as String?,
      utilisateur: json['utilisateur'] != null
          ? Utilisateur.fromJson(json['utilisateur'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return {
      'token': state.token,
      'utilisateur': state.utilisateur?.toJson(),
    };
  }
}
