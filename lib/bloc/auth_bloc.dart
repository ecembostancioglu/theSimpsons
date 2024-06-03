
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesimpsons/core/auth_service.dart';
import 'package:thesimpsons/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();

  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) {});

    on<SignUpUser>((event, emit) async { //Sign Up olayını dinler
      try {
        final UserModel? user =
        await authService.signUpUser(event.email, event.password, event.name, event.surname); //email ve password ile user oluşturmaya çalışır
        if (user != null) {
          await FirebaseFirestore.instance.collection('users').doc(user.id).set({ //Firestore'a kullanıcı bilgilerini kaydetme
            'name': event.name,
            'surname': event.surname,
            'email': event.email,
          });
          emit(AuthSuccessState(user)); //Kayıt olma başarılı

        } else {
          emit(const AuthFailureState('create user failed')); // Hesap oluşturma başarısız hatası
        }
      } catch (e) {
        print(e.toString());
      }
    });

    on<SignInUser>((event, emit) async {
      try {
        final UserModel? user =
        await authService.signInUser(event.email, event.password);
        if (user != null) {
          emit(AuthSuccessState(user));

        } else {
          emit(const AuthFailureState('incorrect entry'));
        }
      } catch (e) {
        print(e.toString());
      }
    });

    on<SignOut>((event, emit) async {
      try {
        authService.signOutUser();
      } catch (e) {
        print(e.toString());
      }
    });

    on<ResetEmail>((event,emit) async{
      try {
        authService.passwordResetWithMail(mail: event.email);
        emit(AuthResetEmailState());
      }catch (e){
        print(e.toString());
        emit(const AuthFailureState('Password reset failed'));
      }
    });
  }
}