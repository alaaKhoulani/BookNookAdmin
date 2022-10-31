import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  AdminRepository _adminRepository = AdminRepository(AdminWebServices());

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String fcmToken,
  }) async {
    emit(RegisterSubmitting());
    try {
      String token = await _adminRepository.register(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          fcmToken: fcmToken);
      if (token != '') {
        Store.store.write('token', token);
        Store.token = token;
        if (isClosed) return;
        
        emit(RegisterSuccess());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(RegisterFailure(exception: e));
    }
  }
  
  Future<void> ProviderlogIn({
    required String email,
    required String provider_id,
    required String fcmToken,
  }) async {
    emit(RegisterSubmitting());
    try {
      String token = await _adminRepository.ProviderLogIn(
          email: email, provider_id: provider_id, fcmToken: fcmToken);
      if (token != '') {
        Store.store.write('token', token);
        Store.token = token;
        if (isClosed) return;

        emit(RegisterSuccess());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(RegisterFailure(exception: e));
    }
  }
}
