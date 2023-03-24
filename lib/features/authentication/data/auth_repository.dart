import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:http/http.dart' as http;

class AuthRepository{
  //
 static Future<UserState> checkIfUserExists(var data)async
 {
    final responseBody= await NetworkService.getPostApiResponse('https://www.tessera.social/api/auth/emailexist', data);
    print('RESPONSE BODY LOGIN');
    print(responseBody);
    if (responseBody['exist']==true)
    {
      return UserState.login;
    }
    else{
      return UserState.signup;
    }
 }
  static Future<bool> checkIfSignUpValid(var data)async
 {
    final responseBody= await NetworkService.getPostApiResponse('https://www.tessera.social/api/auth/signup', data);
    return responseBody['sucess'];
 }
  static Future checkIfLogInValid(var data)async
 {
    final responseBody= await NetworkService.getPostApiResponse('https://www.tessera.social/api/auth/login', data);
    return responseBody;
 }

   static Future<bool> checkForgetPassword(var data)async
 {
    final responseBody= await NetworkService.getPostApiResponse('https://www.tessera.social/api/auth/forgetPassword', data);
    return responseBody['success'];
 }
}
