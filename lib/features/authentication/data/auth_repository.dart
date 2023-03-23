import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:http/http.dart' as http;

class AuthRepository{
  //
 static Future<UserState> checkIfUserExists(var data)async
 {
    final responseBody= await NetworkService.getPostApiResponse('https://www.tessera.social/api/auth/emailexist', data);
    if (responseBody['exists']==true)
    {
      return UserState.login;
    }
    else{
      return UserState.signup;
    }
 }
  static Future<bool> checkIfSignUpValid(var data)async
 {
    final responseBody= await NetworkService.getPostApiResponse('https://www.tessera.social/api/auth/emailexist', data);
    return responseBody['sucess'];
 }
}
