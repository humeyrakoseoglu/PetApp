import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pet/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:pet/features/data/data_sources/remote_data_source/remote_data_source_impl.dart';
import 'package:pet/features/data/repository/firebase_repository_impl.dart';
import 'package:pet/features/domain/repository/firebase_repository.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/post/create_post_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/post/delete_post_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/post/like_post_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/post/read_post_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/post/update_post_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/create_user_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/get_users_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/is_sign_in_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/sign_out_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/sign_up_user_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/update_user_usecase.dart';
import 'package:pet/features/presentations/cubit/auth/auth_cubit.dart';
import 'package:pet/features/presentations/cubit/credential/credential_cubit.dart';
import 'package:pet/features/presentations/cubit/post/post_cubit.dart';
import 'package:pet/features/presentations/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:pet/features/presentations/cubit/user/user_cubit.dart';
import 'package:pet/features/presentations/page/post/upload_post_page.dart';

import 'features/domain/usecases/firebase_usecases/comment/create_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/comment/delete_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/comment/like_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/comment/read_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/comment/update_comment_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/read_single_post_usecase.dart';
import 'features/presentations/cubit/comment/comment_cubit.dart';
import 'features/presentations/cubit/post/get_single_post/get_single_post_cubit.dart';

final sl = GetIt.instance; // sl yani service locator

Future<void> init() async {
  // bu fonk içinde sl'i kullanarak tüm sınıflarımızı kaydedeceğiz
  // Cubits
  sl
      .registerFactory( // her talepte bulunduğunda sana yeni instanve vereceği anlamına gelir
        () =>
        AuthCubit(
          signOutUseCase: sl.call(),
          isSignInUseCase: sl.call(),
          getCurrentUidUseCase: sl.call(),
        ),
  );
  sl.registerFactory(
        () =>
        CredentialCubit(
          signUpUserUseCase: sl.call(),
          signInUserUseCase: sl.call(),
        ),
  );

  sl.registerFactory(
        () =>
        UserCubit(
            updateUserUseCase: sl.call(),
            getUsersUseCase: sl.call()
        ),
  );

  sl.registerFactory(
        () =>
        GetSingleUserCubit(
          getSingleUserUseCase: sl.call(),
        ),
  );

  //Post
  sl.registerFactory(() =>
      PostCubit(updatePostUseCase: sl.call(),
          deletePostUseCase: sl.call(),
          likePostUseCase: sl.call(),
          createPostUseCase: sl.call(),
          readPostUseCase: sl.call()),
  );

  sl.registerFactory(
        () => GetSinglePostCubit(
        readSinglePostUseCase: sl.call()
    ),
  );

  // Comment Cubit Injection
  sl.registerFactory(
        () => CommentCubit(
      createCommentUseCase: sl.call(),
      deleteCommentUseCase: sl.call(),
      likeCommentUseCase: sl.call(),
      readCommentUseCase: sl.call(),
      updateCommentUseCase: sl.call(),
    ),
  );

  /*
  Factoryler talep edildiğinde bize her seferinde yeni instanse veriyor.
   */


  // Use Cases
  sl.registerLazySingleton(() =>
      SignOutUseCase(repository: sl
          .call())); //biz istediğimizde hafızada bir instance oluşturulur. Bu sayede uygulama ayağa kaldırılırken hafızada gereksiz yer kaplamaz.
  sl.registerLazySingleton(() =>
      IsSignInUseCase(repository: sl
          .call())); //Sadece çağırıldığı zaman oluşturulması yeterlidir
  sl.registerLazySingleton(() =>
      GetCurrentUidUseCase(repository: sl
          .call())); // bununla çağırdığımızda ilk kez yeni instance verecek ve uygulamanın kullanım ömrü boyunca onlara yapılan sonraki çağrılarda bize aynı instance'ı verecek.
  sl.registerLazySingleton(() =>
      SignUpUserUseCase(repository: sl
          .call())); //Bu bir singleton olduğu için yeni bir instance başlatmayacak
  sl.registerLazySingleton(() =>
      SignInUserUseCase(repository: sl
          .call())); //factory kullanmadık çünkü her seferinde yeni instance istemiyoruz
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUserCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));
  /*
  lazy singleton bir kez yeni instance verir, onu önbelleğe alır ve sonraki çağrılarda aynı eski instance verilir. her seferinde yeni bir instance istemiyoruz. uygulamanın ömrü boyunca
   soyut sınıflar başlatılamaz bu yüzden implementlerini kaydediyoruz
   */

  //Cloud Storage
  sl.registerLazySingleton(() =>
      UploadImageToStorageUseCase(repository: sl.call()));
  //Post
  sl.registerLazySingleton(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadPostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadSinglePostUseCase(repository: sl.call()));

  // Comment
  sl.registerLazySingleton(() => CreateCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteCommentUseCase(repository: sl.call()));


  // Repository
  sl.registerLazySingleton<FirebaseRepository>(() =>
      FirebaseRepositoryImlp(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(firebaseFirestore: sl.call(),
          firebaseAuth: sl.call(),
          firebaseStorage: sl.call()));


  // Externals : Bu kısmı tam anlamadım HÜMEYRAYA SORRRRR

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;


  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}