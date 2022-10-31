part of 'verify_cubit.dart';

@immutable
abstract class VerifyState {}

class VerifyInitial extends VerifyState {}

class VerifySubmitting extends VerifyState {}

class VerifySuccess extends VerifyState {}
class VerifyUnComplete extends VerifyState {}

class VerifyFailure extends VerifyState {
  final Exception exception;

  VerifyFailure({required this.exception});
}
