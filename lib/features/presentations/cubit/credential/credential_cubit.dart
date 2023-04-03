import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet/features/domain/entities/user/user_entity.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/sign_up_user_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUserUseCase signInUserUseCase;
  final SignUpUserUseCase signUpUserUseCase;


  CredentialCubit({ required this.signInUserUseCase, required this.signUpUserUseCase}) : super(CredentialInitial());

  Future<void> signInUser({required String email, required String password}) async {
    emit(CredentialLoading());//kimlik bilgisi yuklemesi
    try {
      await signInUserUseCase.call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch(_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpUser(UserEntity user) async {
    emit(CredentialLoading());
    try {
      await signUpUserUseCase.call(user);
      emit(CredentialSuccess());
    } on SocketException catch(_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
