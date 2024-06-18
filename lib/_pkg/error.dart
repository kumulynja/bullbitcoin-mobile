import 'package:freezed_annotation/freezed_annotation.dart';

sealed class ErrorState<T> {
  final Exception? dbError;
  final Exception? parseError;
  final HttpException? httpError;
  final NetworkException? networkError;

  ErrorState(
      {this.dbError, this.parseError, this.httpError, this.networkError});
}

enum NetworkException { noInternet, timeout, unknown }

enum HttpException { notFound, badRequest, unauthorized, unknown }

abstract class BBException<T> implements Exception {
  const BBException(this.error, {this.title, this.message, this.description});
  final T error;
  final String? title;
  final String? message;
  final String? description;
}

class DatabaseException<T> extends BBException<T> {
  const DatabaseException(T error,
      {String? title, String? message, String? description})
      : super(error, title: title, message: message, description: description);
}

class JsonParseException<T> extends BBException<T> {
  const JsonParseException(T error,
      {String? title, String? message, String? description, this.modal})
      : super(error, title: title, message: message, description: description);
  final String? modal;
}

class WalletException<T> extends BBException<T> {
  const WalletException(T error,
      {String? title, String? message, String? description})
      : super(error, title: title, message: message, description: description);
}

class WalletLoadException<T> extends WalletException<T> {
  const WalletLoadException(T error,
      {String? title, String? message, String? description})
      : super(error, title: title, message: message, description: description);
}

class WalletDeleteException<T> extends WalletException<T> {
  const WalletDeleteException(T error,
      {String? title, String? message, String? description})
      : super(error, title: title, message: message, description: description);
}

class BdkException<T> extends BBException<T> {
  const BdkException(T error,
      {String? title, String? message, String? description})
      : super(error, title: title, message: message, description: description);
}

class BdkElectrumException<T> extends BdkException<T> {
  const BdkElectrumException(T error,
      {String? title, String? message, String? description, this.serverUrl})
      : super(error, title: title, message: message, description: description);
  final String? serverUrl;
}

class SeedException<T> extends BBException<T> {
  const SeedException(T error,
      {String? title, String? message, String? description})
      : super(error, title: title, message: message, description: description);
}
