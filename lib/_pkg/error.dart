sealed class ErrorState<T> {
  final Exception? dbError;
  final Exception? parseError;
  final HttpException? httpError;
  final NetworkException? networkError;

  ErrorState(
      {this.dbError, this.parseError, this.httpError, this.networkError});
}

class DBError<T> extends ErrorState<T> {
  DBError(Exception? dbError) : super(dbError: dbError);
}

class ParseError<T> extends ErrorState<T> {
  ParseError(Exception? parseError) : super(parseError: parseError);
}

class HttpError<T> extends ErrorState<T> {
  HttpError(HttpException? httpError) : super(httpError: httpError);
}

class NetworkError<T> extends ErrorState<T> {
  NetworkError(NetworkException? networkError)
      : super(networkError: networkError);
}

enum NetworkException { noInternet, timeout, unknown }

enum HttpException { notFound, badRequest, unauthorized, unknown }

class DatabaseException implements Exception {
  const DatabaseException(this.error);
  final Object error;
}

// class IsarException extends DatabaseException {
//   const IsarException(Object error) : super(error);
// }

class JsonParseException implements Exception {
  const JsonParseException(this.error, {this.modal});
  final Object error;
  final String? modal;
}

abstract class WalletException implements Exception {
  const WalletException(this.error);
  final Object error;
}

class WalletLoadException extends WalletException {
  const WalletLoadException(super.error);
}

abstract class BdkException implements Exception {
  const BdkException(this.error);
  final Object error;
}

class BdkElectrumException extends BdkException {
  const BdkElectrumException(super.error, {this.serverUrl});
  final String? serverUrl;
}
