import 'package:pet/features/domain/repository/firebase_repository.dart';

import '../../../entities/user/user_entity.dart';

class SignUpUserUseCase {
  final FirebaseRepository repository;

  SignUpUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signUpUser(user);
  }
}