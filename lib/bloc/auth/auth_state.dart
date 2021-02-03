part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String token;
  final bool loggedIn;
  final DataStatus status;

  const AuthState({@required this.token, @required this.loggedIn, @required this.status});

  @override
  List<Object> get props => [token, loggedIn, status];

  @override
  String toString() {
    return 'AuthState{token: $token, loggedIn: $loggedIn, status: $status}';
  }
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(token: "", loggedIn: false, status: DataStatus.ParsingException);
}
