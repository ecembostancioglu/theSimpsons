part of 'auth_bloc.dart';

abstract class AuthEvent{
  const AuthEvent();

  List<Object> get probs => [];
}

class SignUpUser extends AuthEvent{ //Kayıt için 4 parametre alır.
  final String email;
  final String password;
  const SignUpUser(this.email, this.password);

  List<Object> get props => [email, password];
}

class SignInUser extends AuthEvent{ // Giriş için 2 parametre alır.
  final String email;
  final String password;

  const SignInUser(this.email, this.password);

  List<Object> get props => [email, password];
}

class SignOut extends AuthEvent{}