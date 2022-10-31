import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/models/address.dart';
import 'package:book_nook_admin/data/models/admin.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  AdminRepository _adminRepository = AdminRepository(AdminWebServices());
  File? imageFile;

  void setImage(File image) {
    this.imageFile = image;
    emit(ImageSelectedState(imageFile));
  }

  Future<void> profile() async {
    try {
      emit(ProfileSubmitting());
      Admin admin = await _adminRepository.profile();

      if (admin != null) {
        Store.store.write('admin', admin);
        Store.myAdmin = admin;
        print(Store.myAdmin.image);
        emit(ProfileSuccess(admin: admin));
        print("adminnnnn");
        print(admin);
        // return admin;
      } else {
        // return Admin();
      }
    } on Exception catch (e) {
      // return Admin();
      emit(ProfileFailure(exception: e));
    }
  }

  Future<void> editProfile(
      {required String firstName,
      required String middletName,
      required String lastName,
      required String libraryName,
      required String phonNumber,
      required String? start,
      required String? end
      // required String /,
      }) async {
    try {
      print("ProfileSubmitting");
      emit(ProfileSubmitting());
      bool ok = await _adminRepository.editProfile(
          firstName: firstName,
          middleName: middletName,
          lastyName: lastName,
          libraryName: libraryName,
          phonNumber: phonNumber,
          start: start.toString(),
          end: end.toString(),
          token: Store.token!);
      if (imageFile != null) _adminRepository.addPhoto(image: this.imageFile!);
      if (isClosed) return;
      emit(ProfileEditingSuccess());
    } on Exception catch (e) {
      emit(ProfileFailure(exception: e));
    }
  }

  Future<void> getAddress() async {
    try {
      emit(ProfileSubmitting());
      List<Address> addresses = await _adminRepository.getAddresses();
      // Store.store.remove('address');
      Store.address = addresses;
      // Store.store.write('address', addresses);
      for (var i = 0; i < Store.address.length; i++) {
        print(addresses[i].details);
      }
      emit(GetAddressSuccess(addresses: addresses));
    } on Exception catch (e) {
      emit(ProfileFailure(exception: e));
    }
  }

  Future<void> editAddress(
      {required String title,
      required String area,
      required String street,
      required String floor,
      required String near,
      String details = ''}) async {
    try {
      emit(ProfileSubmitting());
      bool ok = await _adminRepository.editAdress(
          title: title,
          area: area,
          street: street,
          floor: floor,
          near: near,
          details: details);
      if (ok) {
        if (isClosed) return;
        Store.address.clear();
        // Store.store.remove('address');
        emit(EditAddressSuccessful());
        print("hi");
        return;
      }
    } on Exception {
      emit(ProfileFailure(exception: Exception()));
    }
  }

  Future<void> logOut() async {
    emit(LogOutSubmetting());
    bool ok = await _adminRepository.logOut();
    if (ok == true) {
      Store.store.remove('token');
      Store.token = null;
      Store.store.remove('admin');
      emit(LogOutSuccessful());
    } else
      emit(ProfileFailure(exception: Exception()));
  }
}
