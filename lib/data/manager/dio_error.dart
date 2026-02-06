// To parse this JSON data, do
//
//     final dioErrorResponse = dioErrorResponseFromJson(jsonString);

import 'dart:convert';

DioErrorResponse dioErrorResponseFromJson(String str) =>
    DioErrorResponse.fromJson(json.decode(str));

String dioErrorResponseToJson(DioErrorResponse data) =>
    json.encode(data.toJson());

class DioErrorResponse {
  final ErrorResponse? error;

  DioErrorResponse({
    this.error,
  });

  factory DioErrorResponse.fromJson(Map<String, dynamic> json) =>
      DioErrorResponse(
        error: json["error"] == null
            ? null
            : ErrorResponse.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error?.toJson(),
      };
}

class ErrorResponse {
  final int? status;
  final String? message;

  ErrorResponse({
    this.status,
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
