import 'dart:convert';

import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:tessera/features/atendee_management/cubit/atendeeManagement_cubit.dart';
import 'package:tessera/features/event_creation/data/organiser_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:tessera/core/services/networking/exceptions.dart';

class AtendeeManagementRepository {
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjQzYTU2NzA2ZjU1ZTkwODVkMTkzZjQ4IiwiaWF0IjoxNjgzNDUyOTc0LCJleHAiOjE2ODM1MzkzNzR9.bym3bG2pig4Ew4mLOL5TdLlJUv2w1ps6BxFTMSrW714';
  static final Map<String, String> _headers = {
    'Accept-Charset': 'utf-8',
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjQzYTU2NzA2ZjU1ZTkwODVkMTkzZjQ4IiwiaWF0IjoxNjgzNDUyOTc0LCJleHAiOjE2ODM1MzkzNzR9.bym3bG2pig4Ew4mLOL5TdLlJUv2w1ps6BxFTMSrW714'
  };
  Future addAtendee(var data) async {
    try {
      print(data);
      final response = await getPostApiResponse(
          'https://www.tessera.social/api/manage-attendee/addattendee/6454399919a17b933aed053e',
          data);
      print(response);
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  /// Returns the response body in JSON format from a GET request.
  Future getGetApiResponse() async {
    String url =
        'https://www.tessera.social/api/event-tickets/retrieve-event-ticket-tier/643d1fd3453ffd14bdb7284d';
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

  /// Returns the response body in JSON format from a POST request.
  Future getPostApiResponse(String url, dynamic data) async {
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
}
