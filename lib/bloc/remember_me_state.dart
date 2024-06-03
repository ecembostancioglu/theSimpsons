part of 'remember_me_bloc.dart';


abstract class RememberMeState {
  const RememberMeState();

  @override
  List<Object> get props => [];
}

class RememberMeInitial extends RememberMeState {}

class RememberMeLoaded extends RememberMeState {
  final String email;
  final bool rememberMe;

  const RememberMeLoaded({required this.email, required this.rememberMe});

  @override
  List<Object> get props => [email, rememberMe];
}

class RememberMeUpdated extends RememberMeState {
  final bool rememberMe;

  const RememberMeUpdated({required this.rememberMe});

  @override
  List<Object> get props => [rememberMe];
}

class RememberMeError extends RememberMeState {
  final String error;

  const RememberMeError({required this.error});

  @override
  List<Object> get props => [error];
}