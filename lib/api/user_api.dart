import 'package:http/http.dart' as http;
import 'package:gatecheck_frontend/model/user_model.dart';
import 'package:gatecheck_frontend/api/api_base.dart';


Future<ApiData<GenericUser>> currentUser(http.Client client) {
  return client.get(api + '/user').then((res) {
    return parseResponse(res, (json)=>GenericUser.fromJson(json));
  });
}

Future<ApiData<List<Student>>> getStudents(
    Int32x4List studentIds, bool all, http.Client client) {
  String query;
  if (all) {
    query = "all=true";
  } else {
    query = "uuid=" + studentIds.map(uuidToString).join(',') + "&all=false";
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
