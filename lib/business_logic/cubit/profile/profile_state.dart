part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSubmitting extends ProfileState {}

class ProfileEditingSuccess extends ProfileState {}

class ProfileSuccess extends ProfileState {
  Admin admin;
  ProfileSuccess({required this.admin});
}

class GetAddressSuccess extends ProfileState {
  List<Address> addresses;
  GetAddressSuccess({required this.addresses});
}

class ImageSelectedState extends ProfileState {
  File? imageFile;
  ImageSelectedState(this.imageFile);
}

class LogOutSubmetting extends ProfileState {}

class LogOutSuccessful extends ProfileState {}
class EditAddressSuccessful extends ProfileState {}

class ProfileFailure extends ProfileState {
  final Exception exception;

  ProfileFailure({required this.exception});
}
