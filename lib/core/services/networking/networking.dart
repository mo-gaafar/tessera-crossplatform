import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'exceptions.dart';

class NetworkService {
  static Future getGetApiResponse(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final responseJson = returnResponse(response);
      debugPrint(response.body.toString());
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  static Future getPostApiResponse(String url, dynamic data) async {
    try {
      http.Response response = await http
          .post(Uri.parse(url),
              headers: {"Content-Type": "application/json"}, body: data)
          .timeout(const Duration(seconds: 10));
      final responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }
}

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
