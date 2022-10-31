// import 'package:bloc/bloc.dart';
// import 'package:book_nook_admin/data/models/admin.dart';
// import 'package:book_nook_admin/data/repository/admin_repository.dart';
// import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
// import 'package:book_nook_admin/services/storage/store.dart';
// import 'package:meta/meta.dart';

// part 'log_out_state.dart';

// class LogOutCubit extends Cubit<LogOutState> {
//   LogOutCubit() : super(LogOutInitial());

//   AdminRepository _adminRepository = AdminRepository(AdminWebServices());
//   Future<void> logOut() async {
//     emit(LogOutSubmetting());
//     bool ok = await _adminRepository.logOut();
//     if (ok == true) {
//       Store.store.remove('token');
//       Store.token = null;
//       Store.store.remove('admin');
//       emit(LogOutSuccessful());
//     } else
//       emit(LogOutFailure(exception: Exception()));
//   }
// }
