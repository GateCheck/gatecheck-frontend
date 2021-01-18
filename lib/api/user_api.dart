import 'package:http/http.dart' as http;
import 'package:gatecheck_frontend/model/user_model.dart';
import 'dart:convert';
import 'package:gatecheck_frontend/api/api_data.dart';

String api = '/api/v1';

Future<ApiData<GenericUser>> currentUser(http.Client client) {
  return client.get(api + '/user').then((res) {
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      return ApiData(GenericUser.fromJson(json), DataStatus.Success);
    }
    if (res.statusCode == 401) {
      return ApiData<GenericUser>(null, DataStatus.Unauthorized);
    }
    return ApiData<GenericUser>(null, DataStatus.Failure);
  });
}

Future<ApiData<List<Student>>> getStudents(
    List<int> studentIds, bool all, http.Client client) {
  String query;
  if (all) {
    query = "all=true";
  } else {
    query = "uuid=" + studentIds.join() + "&all=false";
  }
  
  return client.get(api + '/user?' + query).then((res) {
    if (res.statusCode == 200) {
      List<Map<String, dynamic>> json =
          jsonDecode(res.body).cast<Map<String, dynamic>>();
      List<Student> students = json.map((e) => Student.fromJson(e));
      return ApiData(students, DataStatus.Success);
    }

    if (res.statusCode == 401) return ApiData(null, DataStatus.Unauthorized);
    return ApiData(null, DataStatus.Failure);
  });
}

Future<ApiData<void>> deleteUser(http.Client client) {
  return client.delete(api + '/user').then(emptyResponseData);
}

Future<ApiData<void>> updateCurrentUser(GenericUser user, http.Client client) {
  return client.put(api + '/user', body: user.toJson()).then(emptyResponseData);
}

Future<ApiData<void>> updateSpecificUser(GenericUser user, http.Client client) {
  var data = user.toJson();
  return client
      .put(api + '/user/' + data['id'], body: data)
      .then(emptyResponseData);
}

ApiData<void> emptyResponseData(http.Response res) {
  DataStatus status;
  switch (res.statusCode) {
    case 200:
      status = DataStatus.Success;
      break;
    case 401:
      status = DataStatus.Unauthorized;
      break;
    default:
      status = DataStatus.Failure;
      break;
  }
  return ApiData(null, status);
}
