import 'package:pet/features/domain/entities/posts/post_entity.dart';
import 'package:pet/features/domain/repository/firebase_repository.dart';

class ReadPostUseCase {
  final FirebaseRepository repository;

  ReadPostUseCase({required this.repository});

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPost(post);
  }
}