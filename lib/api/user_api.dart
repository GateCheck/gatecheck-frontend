import 'package:http/http.dart' as http;
import 'package:gatecheck_frontend/model/user_model.dart';
import 'package:gatecheck_frontend/api/api_base.dart';


Future<ApiData<GenericUser>> currentUser(String token) {
  return client.get(api + '/user', headers: {"Authorization": "Bearer $token"}).then((res) {
    return parseResponse(res, (json) => GenericUser.fromJson(json));
  });
}

Future<ApiData<List<Student>>> getStudents(Int32x4List studentIds, bool all, String token) {
  String query;
  if (all) {
    query = "all=true";
  } else {
    query = "uuid=" + studentIds.map(uuidToString).join(',') + "&all=false";
  }

  return client.get(api + '/user?' + query, headers: {"Authorization": "Bearer $token"}).then((res) {
    return parseResponse(res, (value) {
      List<Map<String, dynamic>> json = value.cast<Map<String, dynamic>>();
      List<Student> students = json.map((e) => Student.fromJson(e));
      return students;
    });
  });
}

/// does not immediately delete user, just prompts the server to send him an email to delete himself

Future<ApiData<void>> deleteUser(String token) {
  return client.delete(api + '/user', headers: {"Authorization": "Bearer $token"}).then(emptyResponseData);
}

Future<ApiData<void>> updateCurrentUser(GenericUser user, String token) {
  return client.put(api + '/user', body: user.toJson(), headers: {"Authorization": "Bearer $token"}).then(emptyResponseData);
}

Future<ApiData<void>> updateSpecificUser(GenericUser user, String token) {
  var data = user.toJson();
  return client
      .put(api + '/user/' + data['id'], body: data, headers: {"Authorization": "Bearer $token"})
      .then(emptyResponseData);
}
