part of 'offer_cubit.dart';

@immutable
abstract class OfferState {}

class OfferInitial extends OfferState {}

class OfferGetSuccessful extends OfferState {
  final List<Offer> offers;

  OfferGetSuccessful(this.offers);
}
