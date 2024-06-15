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
  const BBException(this.error, {this.message});
  final T error;
  final String? message;
}

class DatabaseException<T> implements BBException<T> {
  const DatabaseException(this.error, {this.message});
  final T error;
  final String? message;
}

class JsonParseException<T> implements BBException<T> {
  const JsonParseException(this.error, {this.message, this.modal});
  final T error;
  final String? message;
  final String? modal;
}

abstract class WalletException<T> implements BBException<T> {
  const WalletException(this.error, {this.message});
  final T error;
  final String? message;
}

class WalletLoadException<T> extends WalletException<T> {
  const WalletLoadException(super.error, {super.message});
}

abstract class BdkException<T> implements BBException<T> {
  const BdkException(this.error, {this.message});
  final T error;
  final String? message;
}

class BdkElectrumException<T> extends BdkException<T> {
  const BdkElectrumException(super.error, {super.message, this.serverUrl});
  final String? serverUrl;
}

class SeedException<T> implements BBException<T> {
  const SeedException(this.error, {this.message});
  final T error;
  final String? message;
}
