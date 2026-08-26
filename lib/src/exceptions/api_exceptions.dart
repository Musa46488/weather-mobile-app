/// Custom API exception so callers can map to user-friendly messages.
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}
