// ignore_for_file: lines_longer_than_80_chars

import 'package:formz/formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum MotDePasseValidationError {
  /// Generic invalid error.
  invalid,
}

extension MotDePasseValidationErrorX on MotDePasseValidationError {
  /// Humanized error message.
  String text() {
    switch (this) {
      case MotDePasseValidationError.invalid:
        return 'Le mot de passe doit contenir au moins 8 caractères, dont au moins une lettre et un chiffre.';
    }
  }
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class MotDePasseInput extends FormzInput<String, MotDePasseValidationError> {
  /// {@macro password}
  const MotDePasseInput.pure() : super.pure('');

  /// {@macro password}
  const MotDePasseInput.dirty([super.value = '']) : super.dirty();

  static final _motDePasseRegExp = RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$',
  );

  @override
  MotDePasseValidationError? validator(String? value) {
    return _motDePasseRegExp.hasMatch(value ?? '')
        ? null
        : MotDePasseValidationError.invalid;
  }
}
