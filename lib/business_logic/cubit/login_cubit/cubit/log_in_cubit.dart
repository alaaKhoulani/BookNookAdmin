import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/Screens/log_in.dart';
import 'package:meta/meta.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  AdminRepository _adminRepository = AdminRepository(AdminWebServices());

  Future<void> LogIn({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    emit(LogInInSubmitting());
    try {
      String token = await _adminRepository.logIn(
          email: email,
          password: password,
          fcmToken: fcmToken);
      if (token != '' && token.isNotEmpty && token!=null){
        Store.store.write('token', token);
        Store.token = token;
        if (isClosed) return;
        emit(LogInSuccess());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(LogInInFailure(exception: e));
    }
  }
}
