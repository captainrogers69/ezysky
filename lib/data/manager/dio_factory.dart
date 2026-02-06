import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'dio_config.dart';
import 'dio_error.dart';
import 'dio_log_intercepter.dart';

// typedef OnDioError = void Function(DioErrorResponse);

enum DioAPIException { unauthorized, notfound, connectionfailed, other }

typedef OnDioResponse<Response> = void Function(
    Response? response, DioErrorResponse error);

class DioFactory {
  static final _singleton = DioFactory._instance();

  static Dio? get dio => _singleton._dio;
  // static var _authorization = '';
  // static void initialiseHeaders(String token) {
  //   if (token == "") {
  //     _authorization = "";
  //   } else {
  //     _authorization = 'Bearer $token';
  //   }
  //   dio!.options.headers[HttpHeaders.authorizationHeader] = _authorization;
  // }

  Dio? _dio;

  DioFactory._instance() {
    _dio = Dio(
      BaseOptions(
        // Set reasonable timeouts for weak internet connections.
        // 20 seconds for connect, 30 seconds for receive, 30 seconds for send.
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 40),
        sendTimeout: const Duration(seconds: 40),
        baseUrl: '',
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      ),
    );
    if (!kReleaseMode) {
      _dio?.interceptors.add(
        DioLogInterceptor(
          request: DioConfig.logNetworkRequest,
          requestHeader: DioConfig.logNetworkRequestHeader,
          requestBody: DioConfig.logNetworkRequestBody,
          responseHeader: DioConfig.logNetworkResponseHeader,
          responseBody: DioConfig.logNetworkResponseBody,
          error: DioConfig.logNetworkError,
        ),
      );
    }
  }
}

class ApiEndPoints {
  static const bool useProdInDebug = true;
  static const bool useProdInRelease = true;

  //TODO: production environment

  // static String env = kReleaseMode
  //     ? (useProdInRelease ? '' : 'stage.')
  //     : (useProdInDebug ? '' : 'stage.');

  // static String baseUrl = 'https://${env}api.sys.in/';
  static String baseUrl = "https://api.open-meteo.com/v1/forecast";
}
