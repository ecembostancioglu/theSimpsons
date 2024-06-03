part of 'auth_bloc.dart';

abstract class AuthState{
  const AuthState();

  List<Object> get probs => [];
}

class AuthInitialState extends AuthState{} //Başlangıç durumu

class AuthSuccessState extends AuthState{ //Yükleme başarılı
  final UserModel user;

  const AuthSuccessState(this.user);
  @override
  List<Object> get props => [user]; // Yükleme başarılıysa kullanıcılar döndürülecek
}

class AuthFailureState extends AuthState { //Yüklenemedi
  final String errorMessage;

  const AuthFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];  //Yüklenemezse hata mesajı döndürülecek

}


class AuthResetEmailState extends AuthState{}