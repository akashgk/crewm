abstract class Validators<T> {
  final String validationErrorMessage;

  Validators(this.validationErrorMessage);

  bool validate(dynamic value);
}
