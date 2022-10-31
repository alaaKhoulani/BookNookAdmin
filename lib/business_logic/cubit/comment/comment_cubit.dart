import 'package:bloc/bloc.dart';
import 'package:book_nook_admin/data/models/comment.dart';
import 'package:book_nook_admin/data/repository/comment_repository.dart';
import 'package:meta/meta.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());
  CommentRepository _commentRepository = CommentRepository();

  List<Comment> mycomments = [];

  //--------------------- get quotes in one book----------------------
  Future<void> getBookComment({required int id}) async {
    try {
      // int x = this.comments.length;
      emit(CommentInitial());
      List<Comment> comment =
          await _commentRepository.getBookComments(id: id) as List<Comment>;
      this.mycomments = comment;
      emit(CommentGetSuccess(mycomments));
    } catch (e) {
      emit(CommentFailure(exception: Exception()));
    }
  }
  //-------------------------- add quote----------------------------

  Future<void> addComment({required String comment, required int id}) async {
    try {
      emit(CommentPostSubmetting());
      // print("QuotesPostSubmetting");
      bool ok = await _commentRepository.addComment(comment: comment, id: id);
      print("ok=$ok");
      if (ok == true) {
        if (isClosed) return;
        emit(CommentPostSuccess());
        // print("QuotesPostSuccess");
      }
    } catch (e) {
      // throw
    }
  }
}
