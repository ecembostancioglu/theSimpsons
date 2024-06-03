import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thesimpsons/constants/text_constants.dart';
part 'remember_me_event.dart';
part 'remember_me_state.dart';

class RememberMeBloc extends Bloc<RememberMeEvent, RememberMeState>{

  RememberMeBloc() : super(RememberMeInitial()) {
    on<LoadRememberMe>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final email = prefs.getString(TextConstants.email) ?? "";
        final rememberMe = prefs.getBool(TextConstants.remember_me) ?? false;
        emit(RememberMeLoaded(email: email, rememberMe: rememberMe));
      } catch (e) {
        emit(RememberMeError(error: e.toString()));
      }
    });

    on<SetRememberMe>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(TextConstants.remember_me, event.rememberMe);
        await prefs.setString(TextConstants.email, event.email);
        emit(RememberMeUpdated(rememberMe: event.rememberMe));
      } catch (e) {
        emit(RememberMeError(error: e.toString()));
      }
    });
  }

}