import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'dart:core';

Int32x4 stringToUUID(String str) {
  List<int> a = new Uuid().parse(str);
  return new Int32x4(a[0], a[1], a[2], a[3]);
}
String uuidToString(Int32x4 uuid){
  List<int> a=[uuid.x,uuid.y,uuid.z,uuid.w];
  return new Uuid().unparse(a);
}
