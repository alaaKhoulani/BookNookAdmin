import 'package:book_nook_admin/data/models/comment.dart';
import 'package:book_nook_admin/data/web_services/comment_web_services.dart';

class CommentRepository {
  CommentWebServices _commentWebServices = CommentWebServices();

    Future<List> getBookComments({
    required int id,
  }) async {
    print("====================");
    final quotes = await _commentWebServices.getBookComments(id: id);
    return quotes.map((quote) => Comment().fromJson(quote)).toList();
  }

  Future<bool> addComment({required String comment, required int id}) async {
    return await _commentWebServices.addComment(comment: comment, id: id);
  }
}
