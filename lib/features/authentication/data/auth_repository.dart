import 'package:tessera/core/services/networking/networking.dart';

class AuthRepository {
  static Future<Map> socialAccountLogin(String service, String data) async {
    final response = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/user/auth/$service/app', data);

    return response;
  }
}
