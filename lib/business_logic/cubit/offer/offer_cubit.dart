import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/models/offers.dart';
import 'package:book_nook_admin/data/repository/library_repository.dart';
import 'package:meta/meta.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(OfferInitial());
  LibraryRepository _libraryRepository = LibraryRepository();

  Future<List<Offer>> getLibraryOffers({required int id}) async {
    try {
      emit(OfferInitial());
      List<Offer> offers = await _libraryRepository.getLibraryOffers(id: id);
      
      // if (isClosed) return offers;
      emit(OfferGetSuccessful(offers));
      return offers;
    } catch (e) {
      return [];
    }
  }
}
