class UploadFileException implements Exception {
  /**
   * A message describing the format error.
   */
  final String message;

  /**
   * Creates a new FormatException with an optional error [message].
   */
  const UploadFileException([this.message = ""]);

  String toString() => "UploadFileException: $message";
}