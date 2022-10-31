import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:meta/meta.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(VerifyInitial());
  AdminRepository _userRepository = AdminRepository(AdminWebServices());

  Future<void> isVerify({required String token}) async {
    try {
      emit(VerifySubmitting());
      bool is_verify = await _userRepository.isVerify(token: token);
      if (is_verify) {
        Store.store.write("is_verify", is_verify);
        Store.is_verify = is_verify;
        if (isClosed) return;
        emit(VerifySuccess());
      } else {
        if (isClosed) return;
        emit(VerifyUnComplete());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(VerifyFailure(exception: e));
    }
  }
}
