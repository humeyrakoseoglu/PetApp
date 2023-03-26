import 'package:pet/features/domain/repository/firebase_repository.dart';

import '../../../entities/user/user_entity.dart';

class SignInUserUseCase {
  final FirebaseRepository repository;

  SignInUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signInUser(user);
  }
}