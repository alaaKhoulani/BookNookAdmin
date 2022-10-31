part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentPostSubmetting extends CommentState {}
class CommentPostSuccess extends CommentState {}
class CommentGetSuccess extends CommentState {
  final List<Comment> comment;

  CommentGetSuccess(this.comment);
}

class CommentFailure extends CommentState {
  final Exception exception;

  CommentFailure({required this.exception});
}
