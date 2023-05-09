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

  /// Returns the response body in JSON format from a GET request.
  static Future getGetApiResponse(String url, {String? token}) async {
    try {
      final response = await http.get(Uri.parse(url),
          headers: token != null ? {'Authorization': 'Bearer $token'} : null);
      final responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  /// Returns the response body in JSON format from a POST request.
  static Future getPostApiResponse(String url, dynamic data,
      {String? token}) async {
    Map<String, String> headers = {..._headers};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: data,
          )
          .timeout(const Duration(seconds: 10));
      final responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  /// Returns the response body in JSON format from a POST request.
  static Future getPutApiResponse(String url, dynamic data,{String? token}) async {
    Map<String, String> headers = {..._headers};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: data,
          )
          .timeout(const Duration(seconds: 10));
      final responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }
  static Future uploadFile(String url, String filePath) async {
    try {
      var postUri = Uri.parse(url);
      http.MultipartRequest request = http.MultipartRequest("POST", postUri);

      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('csvFile', filePath);

      request.files.add(multipartFile);

      http.StreamedResponse response = await request.send();

      var responseJson = await response.stream.bytesToString();
      print(responseJson);
      return responseJson;
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
      return jsonDecode(response.body);
    case 404:
      return jsonDecode(response.body);
    case 500:
      throw BadRequestException(response.body.toString());
    default:
      throw FetchDataException(
          "Error accourded while communicating with server with status code ${response.statusCode}");
  }
}
