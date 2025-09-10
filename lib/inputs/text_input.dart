import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum TextValidationError {
  /// Generic invalid error.
  invalid,
}

/// Mise en forme de l'erreur
extension TextValidationErrorText on TextValidationError {
  /// Retourne le message d'erreur
  String text() {
    switch (this) {
      case TextValidationError.invalid:
        return '''Le texte n'est pas valide''';
    }
  }
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class TextInput extends FormzInput<String, TextValidationError> {
  /// {@macro email}
  const TextInput.pure() : super.pure('');

  /// {@macro email}
  const TextInput.dirty([super.value = '']) : super.dirty();

  @override
  TextValidationError? validator(String? value) {
    return value != null ? null : TextValidationError.invalid;
  }
}
