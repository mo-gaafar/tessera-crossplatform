class EmailAuthService {
  String email='';
  String? password='';
  String? username='';
  bool setEmail(String inputEmail)
  {
    email=inputEmail;
    //call function user model we estana ely rage3 menhaa we e3mlo return

    // if return false so will go to sign up this means he is not a user 
    // if return true so will direct to log in this means he is a user
    return false;
  }
}