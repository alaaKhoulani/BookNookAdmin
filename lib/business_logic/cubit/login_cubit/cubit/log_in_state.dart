part of 'log_in_cubit.dart';

@immutable
abstract class LogInState {}

class LogInInitial extends LogInState {}

class LogInInSubmitting extends LogInState {}

class LogInSuccess extends LogInState {}

class LogInInFailure extends LogInState {
  final Exception exception;

  LogInInFailure({required this.exception});
}
