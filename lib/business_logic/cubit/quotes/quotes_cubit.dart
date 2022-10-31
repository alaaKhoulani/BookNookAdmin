import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/models/quote.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/repository/quotes_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:book_nook_admin/data/web_services/quotes_web_services.dart';
import 'package:meta/meta.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit() : super(QuotesInitial());

  QuotesRepository _quotesRepository = QuotesRepository(QuotesWebServices());
  List<Quote> quotes = [];
  late List<Quote> myquotes = [];

  //----------------random quote------------

  Future<Quote> getRandomQuote() async {
    emit(QuotesRandomInitial());
    await _quotesRepository.getAllQuotes().then((quotes) {
      print(quotes);
      this.myquotes = quotes;
      emit(QuotesLoaded(quotes));
    });
    return this.myquotes[new Random().nextInt(myquotes.length)]; //[];
  }

  //--------------------- get quotes in one book----------------------
  Future<void> getBookQuotes({required int id}) async {
    try {
      int x = this.quotes.length;
      emit(QuotesInitial());
      List<Quote> quotes =
          await _quotesRepository.getBookQuotes(id: id) as List<Quote>;
      this.quotes = quotes;
      emit(QuotesSuccess(quotes));
    } catch (e) {
      // emit(QuotesFailure(exception: e));
    }
  }
  //-------------------------- add quote----------------------------

  Future<void> addQuote({required String quote, required int id}) async {
    try {
      emit(QuotesPostSubmetting());
      print("QuotesPostSubmetting");
      bool ok = await _quotesRepository.addQuote(quote: quote, id: id);
      if (ok == true) {
        // QuotesToShow.clear();

        if (isClosed) return;
        emit(QuotesPostSuccess());
        print("QuotesPostSuccess");
      }
    } catch (e) {
      // throw
    }
  }
}
