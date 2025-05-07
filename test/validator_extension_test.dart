import 'package:flutter_test/flutter_test.dart';
import 'package:crewmeister/core/utils/extensions.dart';
import 'package:crewmeister/core/utils/validators.dart';

class DummyValidator<T> extends Validators<T> {
  final bool Function(T value) isValid;
  final String errorMessage;

  DummyValidator({required this.isValid, required this.errorMessage})
    : super(errorMessage);

  @override
  bool validate(dynamic value) {
    if (value is! T) {
      return false;
    }
    return isValid(value);
  }
}

void main() {
  group('MapExtensions.verifyKey', () {
    test('returns correct value when key and type are valid', () {
      final json = {'id': 10};
      final value = json.verifyKey<int>('id');
      expect(value, 10);
    });

    test('throws exception if key is missing', () {
      final json = {'name': 'John'};
      expect(() => json.verifyKey<int>('id'), throwsA(isA<Exception>()));
    });

    test('throws exception if type is incorrect in debug mode', () {
      final json = {'id': 'not an int'};
      expect(() => json.verifyKey<int>('id'), throwsA(isA<Exception>()));
    });

    test('throws exception if validator fails', () {
      final json = {'id': 5};
      final validator = DummyValidator<int>(
        isValid: (v) => v > 10,
        errorMessage: 'Must be greater than 10',
      );
      expect(
        () => json.verifyKey<int>('id', validators: [validator]),
        throwsA(predicate((e) => e.toString().contains('greater than 10'))),
      );
    });

    test('returns value if all validators pass', () {
      final json = {'id': 15};
      final validator = DummyValidator<int>(
        isValid: (v) => v > 10,
        errorMessage: 'Must be greater than 10',
      );
      final value = json.verifyKey<int>('id', validators: [validator]);
      expect(value, 15);
    });
  });

  group('Iterable.mapIndexed', () {
    test('maps with correct index', () {
      final list = ['a', 'b', 'c'];
      final result = list.mapIndexed((i, e) => '$i:$e').toList();

      expect(result, ['0:a', '1:b', '2:c']);
    });

    test('works with empty list', () {
      final list = <String>[];
      final result = list.mapIndexed((i, e) => '$i:$e').toList();
      expect(result, []);
    });
  });
}
