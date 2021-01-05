import 'dart:core';
import 'dart:typed_data';
import 'package:gatecheck_frontend/model/message_model.dart';

enum RequestStatus { Pending, Rejected, Accepted }

class Request {
  String title, destination, details;
  DateTime creationDate, from, to;
  RequestStatus status;
  Int32x4 id, sender;
  List<Int32x4> receivers;
  List<Message> replies;
}
