import 'dart:convert';

import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:http/http.dart' as http;

class AuthRepository{

 static Future<Map> facebookLogin(String service,String data) async {
      final response = await NetworkService.getPostApiResponse(
          'https://www.tessera.social/api/user/auth/$service/app',data);

      return response;
    } 
  }
