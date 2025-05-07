import 'package:flutter/foundation.dart';

import 'validators.dart';

extension MapExtensions on Map<String, dynamic> {
  T? verifyKey<T>(String key, {List<Validators<T>> validators = const []}) {
    if (!containsKey(key)) {
      throw Exception('Missing key "$key"');
    }

    final value = this[key];

    if (value is! T) {
      if (kDebugMode) {
        throw Exception('Invalid type for key "$key"');
      }
      return null;
    }

    for (final validator in validators) {
      if (!validator.validate(value)) {
        throw Exception(validator.validationErrorMessage);
      }
    }

    return value;
  }
}

extension IndexedMap<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E item) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}
