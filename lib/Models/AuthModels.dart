class LoginCredentials {
  String email;
  String password;

  LoginCredentials(
      {required this.email, required this.password});
}

class LoginResults {
  String? token;
  String? statusCode;

  LoginResults(
      {String? token, required this.statusCode}){
        this.token = token ?? null;
      }
}