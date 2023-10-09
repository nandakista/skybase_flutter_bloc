import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skybase/config/network/api_message.dart';
import 'package:skybase/config/network/api_response.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

sealed class NetworkExceptionData with ApiMessage {
  final String? prefix;
  final String? message;
  final Response? response;

  NetworkExceptionData({
    this.prefix,
    this.message,
    this.response,
  });

  @override
  String toString() {
    String result = '';
    if (response?.statusCode == 400 || response?.statusCode == 401) {
      ApiResponse res = ApiResponse.fromJson(response?.data);
      result = convertMessage(res.error ?? res.message);
    } else {
      result += (prefix != null) ? '$prefix, $message' : '$message';
    }
    return result;
  }
}

mixin NetworkException implements Exception {
  NetworkExceptionData handleResponse(Response response) {
    int statusCode = response.statusCode!;
    return switch (statusCode) {
      400 || 403 || 422  => BadRequestException(response: response),
      401 => UnauthorisedException(response: response),
      404 => NotFoundException(response: response),
      409 => FetchDataException(response: response),
      408 => SendTimeOutException(),
      413 => RequestEntityTooLargeException(response: response),
      500 || 503 => InternalServerErrorException(),
      _ => FetchDataException(
        message: 'Received invalid status code: $statusCode',
        response: response,
      ),
    };
  }

  NetworkExceptionData getErrorException(error) {
    if (error is Exception) {
      try {
        NetworkExceptionData networkExceptions;
        if (error is DioException) {
          networkExceptions = switch (error.type) {
            DioExceptionType.cancel => RequestCancelled(),
            DioExceptionType.connectionTimeout => ConnectionTimeOutException(),
            DioExceptionType.receiveTimeout => ReceiveTimeOutException(),
            DioExceptionType.sendTimeout => SendTimeOutException(),
            DioExceptionType.unknown => error.error is SocketException
                ? SocketException()
                : FetchDataException(),
            DioExceptionType.badResponse => handleResponse(error.response!),
            DioExceptionType.badCertificate => BadCertificateException(),
            DioExceptionType.connectionError => ConnectionTimeOutException(),
          };
        } else if (error is SocketException) {
          networkExceptions = SocketException();
        } else {
          networkExceptions = UnexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return FetchDataException();
      } catch (_) {
        return UnexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return UnableToProcess();
      } else {
        return UnexpectedError();
      }
    }
  }
}

final class ConnectionTimeOutException extends NetworkExceptionData {
  ConnectionTimeOutException() : super(message: 'txt_connection_timeout'.tr());
}

final class ReceiveTimeOutException extends NetworkExceptionData {
  ReceiveTimeOutException() : super(message: 'txt_connection_timeout'.tr());
}

final class SendTimeOutException extends NetworkExceptionData {
  SendTimeOutException() : super(message: 'txt_connection_timeout'.tr());
}

final class InternalServerErrorException extends NetworkExceptionData {
  InternalServerErrorException()
      : super(message: 'txt_internal_server_error'.tr());
}

final class RequestEntityTooLargeException extends NetworkExceptionData {
  RequestEntityTooLargeException({Response? response})
      : super(message: 'txt_request_entity_to_large'.tr(), response: response);
}

final class FetchDataException extends NetworkExceptionData {
  FetchDataException({String? message, Response? response})
      : super(
      message: message ?? 'txt_error_during_communication'.tr(),
      response: response);
}

final class NotFoundException extends NetworkExceptionData {
  NotFoundException({String? message, Response? response})
      : super(message: message ?? 'txt_not_found'.tr(), response: response);
}

final class BadRequestException extends NetworkExceptionData {
  BadRequestException({Response? response})
      : super(
      prefix: 'txt_bad_request'.tr(),
      message: '${'txt_message'.tr()}: ${response?.statusMessage}',
      response: response);
}

final class BadCertificateException extends NetworkExceptionData {
  BadCertificateException({Response? response})
      : super(message: 'txt_bad_certificate'.tr(), response: response);
}

final class UnauthorisedException extends NetworkExceptionData {
  UnauthorisedException({Response? response})
      : super(message: 'txt_unauthorized'.tr(), response: response);
}

final class InvalidInputException extends NetworkExceptionData {
  InvalidInputException({Response? response})
      : super(message: 'txt_invalid_input'.tr(), response: response);
}

final class RequestCancelled extends NetworkExceptionData {
  RequestCancelled({Response? response})
      : super(message: 'txt_request_cancel'.tr(), response: response);
}

final class SocketException extends NetworkExceptionData {
  SocketException({Response? response})
      : super(message: 'txt_no_internet_connection'.tr(), response: response);
}

final class UnexpectedError extends NetworkExceptionData {
  UnexpectedError({Response? response})
      : super(message: 'txt_unexpected_error'.tr(), response: response);
}

final class UnableToProcess extends NetworkExceptionData {
  UnableToProcess({Response? response})
      : super(message: 'txt_unable_to_process'.tr(), response: response);
}
