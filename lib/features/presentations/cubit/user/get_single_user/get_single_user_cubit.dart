import 'package:bloc/bloc.dart';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:pet/features/domain/entities/user/user_entity.dart';
import 'package:pet/features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
  GetSingleUserCubit({required this.getSingleUserUseCase}) : super(GetSingleUserInitial());


  Future<void> getSingleUser({required String uid}) async {
    emit(GetSingleUserLoading());
    try {
      final streamResponse = getSingleUserUseCase.call(uid);
      streamResponse.listen((users) {
        emit(GetSingleUserLoaded(user: users.first));
      });
    } on SocketException catch(_) {
      emit(GetSingleUserFailure());
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }

}