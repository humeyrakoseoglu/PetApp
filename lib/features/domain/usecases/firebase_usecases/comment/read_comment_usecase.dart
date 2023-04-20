import '../../../entities/comment/comment_entity.dart';
import '../../../repository/firebase_repository.dart';

class ReadCommentUseCase {
  final FirebaseRepository repository;

  ReadCommentUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}