part of 'add_address_cubit.dart';

@immutable
abstract class AddAddressState {}

class AddAddressInitial extends AddAddressState {}

class AddAddressSubmitting extends AddAddressState {}

class AddAddressSuccess extends AddAddressState {}

class AddAddressFailure extends AddAddressState {
  final Exception exception;

  AddAddressFailure({required this.exception});
}
