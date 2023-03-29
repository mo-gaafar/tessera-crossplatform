/// Used to throw exceptions when the API returns an error code.
class AppException implements Exception {
  /// The message to be displayed to the user.
  final String? _message;

  /// The prefix describing the error to be displayed to the user.
  final String? _prefix;

  /// Creates an [AppException] with the given [message] and [prefix].
  AppException([this._message, this._prefix]);

  /// Returns the message to be displayed to the user as a [String].
  @override
  String toString() {
    return '$_prefix$_message';
  }
}

/// Thrown when an error occurs during communication with the API.
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

/// Thrown when the API returns an invalid request error code.
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

/// Thrown when the API returns an unauthorised request error code.
class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised request');
}

/// Thrown when the API returns an unauthorised input error code.
class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, 'Unauthorised Input');
}
