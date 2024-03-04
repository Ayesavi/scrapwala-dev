extension StringExtension on String {
  String get capitalize {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }

  /// Formats a template string by replacing placeholders with provided arguments.
  ///
  /// The template string can contain placeholders in two formats:
  ///   - `{}`: Positional placeholders are replaced by positional arguments.
  ///   - `{key}`: Named placeholders are replaced by values from the named arguments map.
  ///
  /// If positionalArgs is provided, the function replaces positional placeholders first.
  /// Then, it replaces named placeholders using the namedArgs map.
  ///
  /// Examples:
  ///
  /// ```dart
  /// var name = 'John';
  /// var age = 30;
  /// var message = format('Hello, my name is {} and I am {} years old.', [name, age]);
  /// print(message); // Output: Hello, my name is John and I am 30 years old.
  ///
  /// var message2 = format('Hello, my name is {name} and I am {age} years old.', namedArgs: {'name': name, 'age': age});
  /// print(message2); // Output: Hello, my name is John and I am 30 years old.
  /// ```
  String format(
      {List<dynamic>? positionalArgs, Map<String, dynamic>? namedArgs}) {
    var result = this;

    // Replace positional placeholders
    if (positionalArgs != null && positionalArgs.isNotEmpty) {
      for (int i = 0; i < positionalArgs.length; i++) {
        result = result.replaceFirst('{}', positionalArgs[i].toString());
      }
    }

    // Replace named placeholders
    if (namedArgs != null && namedArgs.isNotEmpty) {
      namedArgs.forEach((key, value) {
        result = result.replaceAll('{$key}', value.toString());
      });
    }

    return result;
  }
}
