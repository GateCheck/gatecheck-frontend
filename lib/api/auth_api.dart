import 'package:gatecheck_frontend/api/user_api.dart';
import 'package:gatecheck_frontend/model/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_base.dart';

Future<ApiData<AuthResponseModel>> login(String username, String password) {
  Map<String, String> body = new Map();
  body['username'] = username;
  body['password'] = password;
  return client.post(api + '/auth/login', body: jsonEncode(body), headers: {'Content-Type': 'application/json'}).then((res) {
    return parseResponse(res, (json) => AuthResponseModel.fromMap(json));
  });
}

Future<ApiData<AuthResponseModel>> register(String username, String email, String name, String school, String password, {bool stayLoggedIn = false}) {
  Map<String, String> body = new Map();
  body['username'] = username;
  body['email'] = email;
  body['name'] = name;
  body['school'] = school;
  body['password'] = password;
  return client.post(api + '/auth/register', body: jsonEncode(body)).then((res) {
    return parseResponse(res, (json) => AuthResponseModel.fromMap(json));
  });
}

Future<bool> isValidToken(Future<String> futureToken) async {
  String token = await futureToken;
  if (token == null)
    return false;
  ApiData<dynamic> testResponse = await currentUser(token);

  return testResponse.status == DataStatus.Success;
}

Future<String> getTokenFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.setString("token", "f"));
  return prefs.getString("token");
}
