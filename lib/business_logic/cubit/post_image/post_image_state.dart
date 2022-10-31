part of 'post_image_cubit.dart';

@immutable
abstract class PostImabeState {}

class PostImabeInitial extends PostImabeState {}

class PostImabeSubmitting extends PostImabeState {}

class PostImabeSuccess extends PostImabeState {}

class PostImabeFailure extends PostImabeState {
  final Exception exception;

PostImabeFailure({required this.exception});
}