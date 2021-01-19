import 'dart:core';
import 'dart:typed_data';
import 'package:gatecheck_frontend/utils/string_uuid_conversion.dart';

enum UserType { User, Student, Instructor, Parent }

class GenericUser {
  UserType type;
  dynamic value;

  GenericUser(UserType type, dynamic value)
      : this.value = value,
        this.type = type;
  GenericUser.fromJson(Map<String,dynamic> json){
    switch(json['data_type']as String){
      case 'User':
        type=UserType.User;
        value=User.fromJson(json);
        break;
      case 'Student':
        type=UserType.Student;
        value=Student.fromJson(json);
        break;
      case 'Instructor':
        type=UserType.Instructor;
        value=Instructor.fromJson(json);
        break;
      case 'Parent':
        type=UserType.Parent;
        value=Parent.fromJson(json);
        break;
    }
  }

  Map<String,dynamic> toJson(){
    String dataType;
    Map<String,dynamic> ret;
    switch(type){
      case UserType.User:
        dataType='User';
        ret=(value as User).toJson();
        break;
      case UserType.Student:
        dataType='Student';
        ret=(value as Student).toJson();
        break;
      case UserType.Instructor:
        dataType='Instructor';
        ret=(value as Instructor).toJson();
        break;
      case UserType.Parent:
        dataType='Parent';
        ret=(value as Parent).toJson();
        break;
    }
    ret['data_type']=dataType;
    return ret;
  }
}

class User {
  String name, username, email, profilePath;
  Int32x4 id;

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        username = json['username'],
        email = json['email'],
        profilePath = json['profilePath'],
        id = stringToUUID(json['id']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'email': email,
        'profilePath': profilePath,
        'id': uuidToString(id)
      };
}

class Student extends User {
  List<Int32x4> instructors, parents;
  String school;

  Student.fromJson(Map<String, dynamic> json)
      : instructors = json['instructors'],
        parents = json['parents'],
        school = json['school'],
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    var ret = super.toJson();
    ret.addAll({
      'instructors': instructors,
      'parents': parents,
      'school': school,
    });
    return ret;
  }
}

class Instructor extends User {
  List<String> schools;
  List<Int32x4> students;

  Instructor.fromJson(Map<String, dynamic> json)
      : schools = json['schools'],
        students = [for (String str in json['students']) stringToUUID(str)],
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    var ret = super.toJson();
    ret.addAll({
      'schools': schools,
      'student': students.map(uuidToString).toList(),
    });
    return ret;
  }
}

class Parent extends User {
  List<Int32x4> children;

  Parent.fromJson(Map<String, dynamic> json)
      : children = [for (String str in json['children']) stringToUUID(str)],
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    var ret = super.toJson();
    ret.addAll({
      'children': children.map(uuidToString).toList(),
    });
    return ret;
  }
}
