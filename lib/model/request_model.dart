import 'dart:core';
import 'dart:typed_data';
import 'package:gatecheck_frontend/model/message_model.dart';
import 'package:gatecheck_frontend/utils/string_uuid_conversion.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum RequestStatus { Pending, Rejected, Accepted }

class Request {
  String title, destination, details;
  DateTime creationDate, from, to;
  RequestStatus status;
  Int32x4 id, sender;
  List<Int32x4> receivers;
  List<Message> replies;

  Request.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        destination = json['destination'],
        details = json['details'],
        creationDate = json['creationDate'],
        from = json['from'],
        to = json['to'],
        status = EnumToString.fromString(RequestStatus.values, json['status']),
        id = stringToUUID(json['id']),
        sender = stringToUUID(json['sender']),
        receivers = [
          for(String str in json['receivers']) stringToUUID(str)
        ],
        replies = [
          for(Map<String,dynamic> m in json['replies']) Message.fromJson(m)
        ];
  Map<String, dynamic> toJson()=>{
    'title':title,
    'destination':destination,
    'details':details,
    'creationDate':creationDate,
    'from':from,
    'to':to,
    'status':EnumToString.convertToString(status),
    'id':uuidToString(id),
    'sender':uuidToString(sender),
    'receivers':receivers.map(uuidToString).toList(),
    'replies':replies.map((e) => e.toJson()).toList()
  };
}
