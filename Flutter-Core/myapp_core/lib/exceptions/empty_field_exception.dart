class EmptyFieldException implements Exception {
  /**
   * A message describing the format error.
   */
  final String message;

  /**
   * Creates a new FormatException with an optional error [message].
   */
  const EmptyFieldException([this.message = ""]);

  String toString() => "EmptyFieldException: $message";
}