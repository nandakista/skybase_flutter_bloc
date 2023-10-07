import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:skybase/config/network/api_message.dart';
import 'package:skybase/config/network/api_response.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class NetworkException implements Exception {
  final String? prefix;
  final String? message;
  final Response? response;

  NetworkException({
    this.prefix,
    this.message,
    this.response,
  });

  @override
  String toString() {
    String result = '';
    if (response?.statusCode == 400 || response?.statusCode == 401) {
      ApiResponse res = ApiResponse.fromJson(response?.data);
      result = ApiMessage.message(res.error ?? res.message);
    } else {
      result += (prefix != null) ? '$prefix, $message' : '$message';
    }
    return result;
  }

  static NetworkException handleResponse(Response response) {
    var statusCode = response.statusCode!;
    switch (statusCode) {
      case 400:
        return BadRequestException(response: response);
      case 401:
        return UnauthorisedException(response: response);
      case 403:
        return BadRequestException(response: response);
      case 404:
        return NotFoundException(response: response);
      case 409:
        return FetchDataException(response: response);
      case 408:
        return SendTimeOutException();
      case 413:
        return RequestEntityTooLargeException(response: response);
      case 422:
        return BadRequestException(response: response);
      case 500:
        return InternalServerErrorException();
      case 503:
        return InternalServerErrorException();
      default:
        var responseCode = statusCode;
        return FetchDataException(
          message: 'Received invalid status code: $responseCode',
          response: response,
        );
    }
  }

  static NetworkException getErrorException(error) {
    if (error is Exception) {
      try {
        NetworkException networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = RequestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = ConnectionTimeOutException();
              break;
            case DioExceptionType.unknown:
              if (error.error is SocketException) {
                networkExceptions = SocketException();
              } else {
                networkExceptions = FetchDataException();
              }
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = ReceiveTimeOutException();
              break;
            case DioExceptionType.badResponse:
              networkExceptions =
                  NetworkException.handleResponse(error.response!);
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = SendTimeOutException();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = BadCertificateException();
              break;
            case DioExceptionType.connectionError:
              networkExceptions = ConnectionTimeOutException();
              break;
          }
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

class ConnectionTimeOutException extends NetworkException {
  ConnectionTimeOutException() : super(message: 'txt_connection_timeout'.tr);
}

class ReceiveTimeOutException extends NetworkException {
  ReceiveTimeOutException() : super(message: 'txt_connection_timeout'.tr);
}

class SendTimeOutException extends NetworkException {
  SendTimeOutException() : super(message: 'txt_connection_timeout'.tr);
}

class InternalServerErrorException extends NetworkException {
  InternalServerErrorException()
      : super(message: 'txt_internal_server_error'.tr);
}

class RequestEntityTooLargeException extends NetworkException {
  RequestEntityTooLargeException({Response? response})
      : super(message: 'txt_request_entity_to_large'.tr, response: response);
}

class FetchDataException extends NetworkException {
  FetchDataException({String? message, Response? response})
      : super(
            message: message ?? 'txt_error_during_communication'.tr,
            response: response);
}

class NotFoundException extends NetworkException {
  NotFoundException({String? message, Response? response})
      : super(message: message ?? 'txt_not_found'.tr, response: response);
}

class BadRequestException extends NetworkException {
  BadRequestException({Response? response})
      : super(
            prefix: 'txt_bad_request'.tr,
            message: '${'txt_message'.tr}: ${response?.statusMessage}',
            response: response);
}

class BadCertificateException extends NetworkException {
  BadCertificateException({Response? response})
      : super(message: 'txt_bad_certificate'.tr, response: response);
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException({Response? response})
      : super(message: 'txt_unauthorized'.tr, response: response);
}

class InvalidInputException extends NetworkException {
  InvalidInputException({Response? response})
      : super(message: 'txt_invalid_input'.tr, response: response);
}

class RequestCancelled extends NetworkException {
  RequestCancelled({Response? response})
      : super(message: 'txt_request_cancel'.tr, response: response);
}

class SocketException extends NetworkException {
  SocketException({Response? response})
      : super(message: 'txt_no_internet_connection'.tr, response: response);
}

class UnexpectedError extends NetworkException {
  UnexpectedError({Response? response})
      : super(message: 'txt_unexpected_error'.tr, response: response);
}

class UnableToProcess extends NetworkException {
  UnableToProcess({Response? response})
      : super(message: 'txt_unable_to_process'.tr, response: response);
}
