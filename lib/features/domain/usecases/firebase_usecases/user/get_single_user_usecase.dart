import 'package:pet/features/domain/entities/user/user_entity.dart';
import 'package:pet/features/domain/repository/firebase_repository.dart';

class GetSingleUserUseCase {
  final FirebaseRepository repository;

  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid ) {
    return repository.getSingleUsers(uid);
  }
}