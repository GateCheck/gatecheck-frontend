export 'dart:convert';
export 'dart:typed_data';
export 'package:gatecheck_frontend/utils/string_uuid_conversion.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String host = "http://localhost:8080";
String api = host + '/api/v1';
http.Client client = new http.Client();


enum DataStatus { Success, Unauthorized, Failure, ParsingException }

/// this class holds data from an api request and the status of the request
class ApiData<T> {
  DataStatus status;
  T data;

  ApiData(T data, DataStatus status)
      : data = data,
        status = status;
}

/// this function takes a response and a toJson constructor for a certain type and returns an ApiData object for the specified type.

ApiData<T> parseResponse<T>(http.Response res, T getResponseFromJson(dynamic json)) {
  if (res.statusCode == 200) {
    try {
      var json = convert.jsonDecode(res.body);
      return ApiData(getResponseFromJson(json), DataStatus.Success);
    } catch (err, stacktrace) {
      return ApiData<T>(err, DataStatus.ParsingException);
    }
  }

  if (res.statusCode == 401 || res.statusCode == 403) {
    return ApiData<T>(null, DataStatus.Unauthorized);
  }
  return ApiData<T>(null, DataStatus.Failure);
}

/// this function takes a response with no body and returns an ApiData<void> according to the status code.

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

String mapToJson<K, V>(Map<K, V> map) {
  return convert.jsonEncode(map);
}
