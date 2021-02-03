class AuthResponseModel {
  bool success;
  int status;
  String message;
  String token;

  AuthResponseModel({this.success, this.status, this.message, this.token});

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return new AuthResponseModel(success: map['success'], status: map['status'], message: map['message'] ?? '', token: map['token'] ?? null);
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {'success': success, 'status': status, 'message': message, 'token': token} as Map<String, dynamic>;
  }
}