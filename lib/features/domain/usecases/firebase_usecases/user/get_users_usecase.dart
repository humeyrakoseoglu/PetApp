import 'package:pet/features/domain/entities/user/user_entity.dart';
import 'package:pet/features/domain/repository/firebase_repository.dart';

class GetUsersUseCase {
  final FirebaseRepository repository;

  GetUsersUseCase({required this.repository});

  Stream<List<UserEntity>>  call(UserEntity user) {
    return repository.getUsers(user);
  }
}