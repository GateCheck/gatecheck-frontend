import 'dart:core';
import 'dart:typed_data';
import 'package:gatecheck_frontend/utils/string_uuid_conversion.dart';

class Message {
  DateTime sendDate;
  Int32x4 sender;
  String text;

  Message.fromJson(Map<String, dynamic> json)
      : sendDate = json['sendDate'],
        sender = StringToUUID(json['sender']),
        text = json['text'];
  Map<String,dynamic> toJson()=>
      {
        'sendDate':sendDate,
        'sender':UUIDToString(sender),
        'text':text
      };
}
