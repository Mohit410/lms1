class ServerExceptionWithMessage<T> implements Exception {
  final String message;
  final T? data;

  ServerExceptionWithMessage(this.message, {this.data});
  @override
  String toString() {
    return message;
  }
}

class ServerException implements Exception {}

class CacheException implements Exception {}
