import 'package:gatecheck_frontend/model/request_model.dart';
import 'package:gatecheck_frontend/api/api_base.dart';
import 'package:http/http.dart' as http;

Future<ApiData<Request>> getRequest(Int32x4 id,http.Client client){
  return client.get(api+"/request/"+uuidToString(id))
      .then((res){
    return parseResponse(res, (json)=>Request.fromJson(json));
  });
}

Future<ApiData<List<Request>>> getMultipleRequests(http.Client client,{bool messages=false, int amount=10, int index=0}){
  String url=api+"/request?messages=$messages&amount=$amount&index=$index";
  return client.get(url).then((res){
    return parseResponse(res, (json){
      List<Map<String, dynamic>>list=json.cast<Map<String, dynamic>>();
      return list.map((e) => Request.fromJson(e));
    });
  });
}