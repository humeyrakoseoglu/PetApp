import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/is_sign_in_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> { //cubitler use casestan verileri nasıl alcak?
  final SignOutUseCase signOutUseCase;//nesneleri olusturucaz once
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  AuthCubit({required this.signOutUseCase, required this.isSignInUseCase, required this.getCurrentUidUseCase}) : super(AuthInitial());

  //uygulama baslatildiginda kullanicinin oturum acip acmadiği kontrol edilecek
  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignIn = await isSignInUseCase.call();
      if (isSignIn == true) {//koşul doğruysa id'yi tut kimliği doğrulanmış konumuna geç
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch(_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn(BuildContext context) async {
    try{
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    }catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut(BuildContext context) async {
    try{
       await signOutUseCase.call();
      emit(UnAuthenticated());
    }catch(_){
      emit(UnAuthenticated());
    }
  }
}
