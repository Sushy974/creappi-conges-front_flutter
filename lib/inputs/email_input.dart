import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum EmailValidationError {
  /// Generic invalid error.
  invalid,
}

/// Mise en forme de l'erreur
extension EmailValidationErrorText on EmailValidationError {
  /// Retourne le message d'erreur
  String text() {
    switch (this) {
      case EmailValidationError.invalid:
        return '''L'email n'est pas valide''';
    }
  }
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class EmailInput extends FormzInput<String, EmailValidationError> {
  /// {@macro email}
  const EmailInput.pure() : super.pure('');

  /// {@macro email}
  const EmailInput.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}
