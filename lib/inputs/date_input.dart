import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum DateValidationError {
  /// Generic invalid error.
  invalid,
}

/// Mise en forme de l'erreur
extension DateValidationErrorText on DateValidationError {
  /// Retourne le message d'erreur
  String text() {
    switch (this) {
      case DateValidationError.invalid:
        return '''La date n'est pas valide''';
    }
  }
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class DateInput extends FormzInput<DateTime?, DateValidationError> {
  /// {@macro email}
  const DateInput.pure() : super.pure(null);

  /// {@macro email}
  const DateInput.dirty([super.value]) : super.dirty();

  @override
  DateValidationError? validator(DateTime? value) {
    return value != null ? null : DateValidationError.invalid;
  }
}
