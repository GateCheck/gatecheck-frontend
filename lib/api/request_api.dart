import 'package:gatecheck_frontend/model/request_model.dart';
import 'package:gatecheck_frontend/model/message_model.dart';
import 'package:gatecheck_frontend/api/api_base.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:enum_to_string/enum_to_string.dart';

Future<ApiData<Request>> getRequest(http.Client client, Int32x4 id) {
  return client.get(api + "/request/" + uuidToString(id)).then((res) {
    return parseResponse(res, (json) => Request.fromJson(json));
  });
}

/**
 * gets a list of requests, it's purpose is for use in a list builder<br>
 * if messages is true, the requests will contain their messages, otherwise, they won't
 */

Future<ApiData<List<Request>>> getMultipleRequests(http.Client client,
    {bool messages = false, int amount = 10, int index = 0}) {
  String url = api + "/request?messages=$messages&amount=$amount&index=$index";
  return client.get(url).then((res) {
    return parseResponse(res, (json) {
      List<Map<String, dynamic>> list = json.cast<
          Map<String, dynamic>>(); //cast the json into a list of json objects
      return list.map((e) => Request.fromJson(e));
    });
  });
}

Future<ApiData<Request>> createRequest(http.Client client, Request r) {
  return client.post(api + "/request", body: r.toJson()).then((res) {
    return parseResponse(res, (json) => Request.fromJson(json));
  });
}

Future<ApiData<Message>> sendMessage(
    http.Client client, String message, Int32x4 requestId) {
  String url = api + "/request/${uuidToString(requestId)}/message";
  var body = {"text": message};
  return client.post(url, body: body).then((res) {
    return parseResponse(res, (json) => Message.fromJson(json));
  });
}

Future<ApiData<void>> deleteRequest(http.Client client, Int32x4 requestId) {
  String url = api + "/request/" + uuidToString(requestId);
  return client.delete(url).then(emptyResponseData);
}

Future<ApiData<void>> deleteMessage(
    http.Client client, Int32x4 requestId, Int32x4 messageId) {
  String url =
      api + "/request/${uuidToString(requestId)}/${uuidToString(messageId)}";
  return client.delete(url).then(emptyResponseData);
}

Future<ApiData<void>> changeRequestStatus(
    http.Client client, Int32x4 requestId, RequestStatus status) {
  String url = api +
      "/request/${uuidToString(requestId)}/status/${EnumToString.convertToString(status)}";
  return client.post(url).then(emptyResponseData);
}

Future<ApiData<void>> updateRequest(http.Client client, Request request) {
  String url = api + "/request/" + uuidToString(request.id);
  return client.put(url, body: request.toJson()).then(emptyResponseData);
}
