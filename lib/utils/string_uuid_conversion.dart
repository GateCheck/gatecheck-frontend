import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'dart:core';

Int32x4 StringToUUID(String str) {
  List<int> a = new Uuid().parse(str);
  return new Int32x4(a[0], a[1], a[2], a[3]);
}
String UUIDToString(Int32x4 UUID){
  List<int> a=[UUID.x,UUID.y,UUID.z,UUID.w];
  return new Uuid().unparse(a);
}
