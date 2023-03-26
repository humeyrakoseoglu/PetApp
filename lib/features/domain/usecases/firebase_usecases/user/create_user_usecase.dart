import 'package:pet/features/domain/entities/user/user_entity.dart';
import 'package:pet/features/domain/repository/firebase_repository.dart';
// usecaseler iş mantığımızın yürütüleceği yer
//Use Cases will get the data from the Repository (Contract) class
//Bloc'un Cubit (Devlet Yönetimi Çözümü) alt kümesi durumunda bunun çok fazla mantık tutmayacağını ancak bunun işini Kullanım Durumlarına devredecek
class CreateUserUserCase {
  final FirebaseRepository repository;

  CreateUserUserCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}