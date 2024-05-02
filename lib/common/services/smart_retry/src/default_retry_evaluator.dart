import 'dart:async';
import 'package:dio/dio.dart';

class DefaultRetryEvaluator {
  DefaultRetryEvaluator(this.retryableStatuses);

  final Set<int> retryableStatuses;

  /// Returns true only if the response hasn't been cancelled
  ///   or got a bad status code.
  // ignore: avoid-unused-parameters
  FutureOr<bool> evaluate(DioException exception, int attempt) {
    bool shouldRetry;
    if (exception.type == DioExceptionType.badResponse) {
      final statusCode = exception.response?.statusCode;
      if (statusCode != null) {
        shouldRetry = isRetryable(statusCode);
      } else {
        shouldRetry = true;
      }
    } else {
      shouldRetry =
          exception.type != DioExceptionType.cancel && exception.error is! FormatException;
    }
    return shouldRetry;
  }

  bool isRetryable(int statusCode) => retryableStatuses.contains(statusCode);
}
