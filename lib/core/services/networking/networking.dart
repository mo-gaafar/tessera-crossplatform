import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'exceptions.dart';

/// Operates as a helper class for making network calls.
///
/// Focuses on implementing GET and POST requests. Responses are first handled
/// by [returnResponse()] and checked for errors before returning their bodies.
class NetworkService {
  static final Map<String, String> _headers = {
    'Accept-Charset': 'utf-8',
    'Content-Type': 'application/json'
  };
  static final Map<String, String> _organizerHeaders = {
    'Accept-Charset': 'utf-8',
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjQzYTU2NzA2ZjU1ZTkwODVkMTkzZjQ4IiwiaWF0IjoxNjgzNTc0MjgxLCJleHAiOjE2ODM2NjA2ODF9.cemAiMZ5KxrH188ZWy8PEc8_lWLJu9J9BOSm9gi1ThE'
  };

  /// Returns the response body in JSON format from a GET request.
  static Future getGetApiResponse(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      final responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  /// Returns the response body in JSON format from a GET request.
  static Future getGetApiResponseOrganizer(String url) async {
    try {
      print('response getGetApiResponseOrganizer');
      final response = await http.get(
        Uri.parse(url),
        headers: _organizerHeaders,
      );
      print(response.statusCode);
      print(response.body.toString());
      final responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  /// Returns the response body in JSON format from a POST request.
  static Future getPostApiResponse(String url, dynamic data) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            headers: _headers,
            body: data,
          )
          .timeout(const Duration(seconds: 10));
      final responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future getPostApiResponseOrganizer(String url, dynamic data) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            headers: _organizerHeaders,
            body: data,
          )
          .timeout(const Duration(seconds: 10));
      if (returnResponse(response)['success'] == true) {
        final responseJson = returnResponse(response);
        return responseJson;
      } else {
        return 'false';
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }
}

/// Checks the response status code and throws an [AppException] if an error is found.
dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return jsonDecode(response.body);
    case 201:
      return jsonDecode(response.body);
    case 400:
      throw BadRequestException(response.body.toString());
    case 404:
      throw BadRequestException(response.body.toString());
    case 500:
      throw BadRequestException(response.body.toString());
    default:
      throw FetchDataException(
          "Error accourded while communicating with server with status code ${response.statusCode}");
  }
}
