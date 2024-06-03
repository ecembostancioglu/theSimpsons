part of 'remember_me_bloc.dart';

abstract class RememberMeEvent {
  const RememberMeEvent();

  @override
  List<Object> get props => [];
}
class LoadRememberMe extends RememberMeEvent {}

class SetRememberMe extends RememberMeEvent {
  final bool rememberMe;
  final String email;

  const SetRememberMe(this.rememberMe, this.email);

  @override
  List<Object> get props => [rememberMe, email];
}