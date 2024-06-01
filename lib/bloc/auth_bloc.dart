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
      emit(AuthLoadingState(isLoading: true)); //Üye olma işleminin devam ettiğini söyler
      try {
        final UserModel? user =
        await authService.signUpUser(event.email, event.password); //email ve password ile user oluşturmaya çalışır
        if (user != null) {
          emit(AuthSuccessState(user)); //Kayıt olma başarılı

        } else {
          emit(const AuthFailureState('create user failed')); // Hesap oluşturma başarısız hatası
        }
      } catch (e) {
        print(e.toString());
      }
      emit(AuthLoadingState(isLoading: false)); //Create user işleminin sonlandığını söyler
    });

    on<SignInUser>((event, emit) async {
      emit(AuthLoadingState(isLoading: true));
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
      emit(AuthLoadingState(isLoading: false));
    });

    on<SignOut>((event, emit) async {
      emit(AuthLoadingState(isLoading: true));
      try {
        authService.signOutUser();
      } catch (e) {
        print('error');
        print(e.toString());
      }
      emit(AuthLoadingState(isLoading: false));
    });
  }
}