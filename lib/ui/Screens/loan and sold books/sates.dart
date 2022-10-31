import 'package:book_nook_admin/ui/Screens/loan%20and%20sold%20books/model.dart';

abstract class LoanBooksStates {}

class LoanBooksInitial extends LoanBooksStates {}

class LoanBooksStartSearch extends LoanBooksStates {}

class LoanBooksStopSearch extends LoanBooksStates {}

class LoanBooksIsDone extends LoanBooksStates {}

class LoanBooksGetData extends LoanBooksStates {
  final List<Borrowed> loanBooks;

  LoanBooksGetData(this.loanBooks);
}
