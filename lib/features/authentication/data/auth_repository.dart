import 'package:tessera/core/services/networking/networking.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

class AuthRepository {
  static Future<UserModel?> googleLoginRequest(UserModel user) async {
    try {
      final response = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/user/auth/google/app',
        {
          'firstname': user.username?.split(' ')[0],
          'lastname': user.username?.split(' ')[1],
          'email': user.email,
          'id': user.userId,
        },
      );

      if (response['success'] == true) {
        // TODO: figure out what to return, might need to edit the UserModel
        // TODO: if we need to store token, return user with new token or edit it in the passed object(?) with setter
        // TODO: if we don't need to store token, return bool success
        // return UserModel.fromJson(response['data']);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
