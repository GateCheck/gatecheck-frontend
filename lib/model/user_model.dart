import 'dart:core';
import 'dart:typed_data';

class User {
  String name, username, email, profilePath;
  Int32x4 UUID;
}

class Student extends User {
  List<Int32x4> instructors, parents;
  String school;
}

class Instructor extends User {
  List<String> schools;
  List<Int32x4> students;
}

class Parent extends User {
  List<Int32x4> children;
}
