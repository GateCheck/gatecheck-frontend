import 'package:http/http.dart' as http;
import 'package:gatecheck_frontend/model/user_model.dart';
import 'dart:convert';
import 'package:gatecheck_frontend/api/api_data.dart';
String api='/api/v1';

Future<ApiData<GenericUser>> currentUser(http.Client client){
  return client.get(api+'/user').then((res){
    if(res.statusCode==200){
      var json=jsonDecode(res.body);
      return ApiData(GenericUser.fromJson(json), DataStatus.Success);
    }
    if(res.statusCode==401){
      return ApiData<GenericUser>(null, DataStatus.Unauthorized);
    }
    return ApiData<GenericUser>(null, DataStatus.Failure);
  });
}

