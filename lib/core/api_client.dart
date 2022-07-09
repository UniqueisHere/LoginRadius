import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Response> registerUser(Map<String, dynamic>? userData) async {
    //IMPLEMENT USER REGISTRATION
    try {
      Response response = await _dio.post(
          'https://api.loginradius.com/identity/v2/auth/register', //ENDPONT URL
          data: userData, //REQUEST BODY
          queryParameters: {
            'apikey': '6e2dcfc6-83f6-4f18-a083-5f2c7257e393'
          }, //QUERY PARAMETERS
          options: Options(headers: {
            'X-LoginRadius-Sott':
                'JnPZNeaOIs2k0mZcjIxB1kEjLckA7muQn8y3lE+XHu70y1hfxpHRYoaeElUGYxSRkmhX+mZ1KeD8MjB2hOGKvisV/wBa1Fb+TEwWHbEBxdo=*a5a2b296735718d10ade54062fb2bf39', //HEADERS
          }));
      //returns the successful json object
      return response;
    } on DioError catch (e) {
      //returns the error object if there is
      return e.response!;
    }
  }

  Future<Response> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'https://api.loginradius.com/identity/v2/auth/login',
        data: {'email': email, 'password': password},
        queryParameters: {'apikey': '6e2dcfc6-83f6-4f18-a083-5f2c7257e393'},
      );
      //returns the successful user data json object
      return response;
    } on DioError catch (e) {
      //returns the error object if any
      return e.response!;
    }
  }

  Future<Response> getUserProfileData(String accesstoken) async {
    try {
      Response response = await _dio.get(
        'https://api.loginradius.com/identity/v2/auth/account',
        queryParameters: {'apikey': '6e2dcfc6-83f6-4f18-a083-5f2c7257e393'},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${accesstoken}',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> logout(String accessToken) async {
    try {
      Response response = await _dio.get(
        'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
        queryParameters: {'apikey': "daed88b8-4de9-4174-a1df-0690a3e06ba8"},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
