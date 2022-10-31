import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:meta/meta.dart';

part 'post_image_state.dart';

class PostImabeCubit extends Cubit<PostImabeState> {
  PostImabeCubit() : super(PostImabeInitial());
  AdminRepository _adminRepository = AdminRepository(AdminWebServices());

  Future<void> addPhoto({required File image}) async {
    try {
    emit(PostImabeSubmitting());

      bool ok = await _adminRepository.addPhoto(image: image);
      if (ok == true) {
        if (isClosed) return;
        emit(PostImabeSuccess());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(PostImabeFailure(exception: e));
    }
  }
}
