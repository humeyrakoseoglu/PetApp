import 'package:pet/features/domain/repository/firebase_repository.dart';

import '../../../entities/user/user_entity.dart';

class UpdateUserUseCase {
  final FirebaseRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.updateUser(user);
  }
}