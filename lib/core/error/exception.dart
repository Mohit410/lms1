class ServerExceptionWithMessage implements Exception {
  final String message;

  ServerExceptionWithMessage(this.message);
  @override
  String toString() {
    return message;
  }
}

class ServerException implements Exception {}

class CacheException implements Exception {}
