class WrongPriceFormatException implements Exception {
  /**
   * A message describing the format error.
   */
  final String message;

  /**
   * Creates a new FormatException with an optional error [message].
   */
  const WrongPriceFormatException([this.message = ""]);

  String toString() => "WrongPriceFormatException: $message";
}