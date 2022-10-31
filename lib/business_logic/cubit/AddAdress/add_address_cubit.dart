import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/business_logic/cubit/add_book/add_book_cubit.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:meta/meta.dart';

part 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit() : super(AddAddressInitial());

  AdminRepository _adminRepository = AdminRepository(AdminWebServices());

  Future<void> addAddress(
      {required String title,
      required String area,
      required String street,
      required String floor,
      required String near,
      String details = ''}) async {
    emit(AddAddressSubmitting());
    try {
      bool ok = await _adminRepository.addAddress(
          title: title, area: area, street: street, floor: floor, near: near);
      if (ok == true) {
        if (isClosed) return;
        print("hijjjjj");
        emit(AddAddressSuccess());
        return;
      } else {
        emit(AddAddressFailure(exception: Exception()));
      }
    } on Exception catch (e) {
      if (isClosed) return;
      emit(AddAddressFailure(exception: e));
    }
  }
}
