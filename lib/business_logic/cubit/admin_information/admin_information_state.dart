part of 'admin_information_cubit.dart';

@immutable
abstract class AdminInformationState {}

class AdminInformationInitial extends AdminInformationState {}
class AdminInformationSubmitting extends AdminInformationState {}

class AdminInformationSuccess extends AdminInformationState {}

class AdminInformationFailure extends AdminInformationState {
  final Exception exception;

  AdminInformationFailure({required this.exception});
}
