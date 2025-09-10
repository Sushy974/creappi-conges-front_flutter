// ignore_for_file: avoid_catches_without_on_clauses

import 'package:bloc/bloc.dart';
import 'package:creappi_conge/models/utilisateur.dart';
import 'package:creappi_conge/inputs/email_input.dart';
import 'package:creappi_conge/inputs/mot_de_passe.dart';
import 'package:creappi_conge/usecases/connexion_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'connexion_event.dart';
part 'connexion_state.dart';

class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState>
    with FormzMixin {
  ConnexionBloc({
    required ConnexionUsecase connexionUsecase,
  }) : _connexionUsecase = connexionUsecase,
       super(const ConnexionState()) {
    on<ConnexionEmailChanged>(_onEmailChanged);
    on<ConnexionMotDePasseChanged>(_onMotDePasseChanged);
    on<ConnexionSubmitted>(_onSubmitted);
    on<ConnexionReset>(_onReset);
  }

  final ConnexionUsecase _connexionUsecase;

  void _onEmailChanged(
    ConnexionEmailChanged event,
    Emitter<ConnexionState> emit,
  ) {
    emit(
      state.copyWith(
        email: EmailInput.dirty(event.email),
      ),
    );
  }

  void _onMotDePasseChanged(
    ConnexionMotDePasseChanged event,
    Emitter<ConnexionState> emit,
  ) {
    emit(
      state.copyWith(
        motDePasse: MotDePasseInput.dirty(event.motDePasse),
      ),
    );
  }

  Future<void> _onSubmitted(
    ConnexionSubmitted event,
    Emitter<ConnexionState> emit,
  ) async {
    if (isNotValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final token = await _connexionUsecase.execute(
        ConnexionCommand(
          email: state.email.value,
          motDePasse: state.motDePasse.value,
        ),
      );
      print(token);
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          token: token.token,
          utilisateur: token.utilisateur,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'Erreur de connexion: $e',
        ),
      );
    }
  }

  void _onReset(
    ConnexionReset event,
    Emitter<ConnexionState> emit,
  ) {
    emit(const ConnexionState());
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [
    state.email,
    state.motDePasse,
  ];
}
