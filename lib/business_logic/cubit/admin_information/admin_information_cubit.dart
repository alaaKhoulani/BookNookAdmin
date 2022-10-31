import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:meta/meta.dart';
part 'admin_information_state.dart';

class AdminInformationCubit extends Cubit<AdminInformationState> {
  AdminInformationCubit() : super(AdminInformationInitial());

    AdminRepository _adminRepository = AdminRepository(AdminWebServices());
  
  Future<void> submitInformation({
    required String firstName,
    required String middleName,
    required String lastyName,
    required String libraryName,
    required String phonNumber,
    required String start,
    required String end,
    required String token, //Bearer
  }) async {
    try {
      bool ok = await _adminRepository.submitInformation(
          firstName: firstName,
          middleName: middleName,
          lastyName: lastyName,
          libraryName: libraryName,
          phonNumber: phonNumber,
          start: start,
          end: end,
          token: token);
      emit(AdminInformationSubmitting());
      if (ok == true) {
        if (isClosed) return;
        emit(AdminInformationSuccess());
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(AdminInformationFailure(exception: e));
    }
  }
}
