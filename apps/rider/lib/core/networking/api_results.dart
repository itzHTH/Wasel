import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/core/networking/errors/error_handler.dart';

part 'api_results.freezed.dart';

@freezed
class ApiResults<T> with _$ApiResults<T> {
  const factory ApiResults.success(T data) = Success<T>;
  const factory ApiResults.failure(ErrorHandler error) = Failure<T>;
}
