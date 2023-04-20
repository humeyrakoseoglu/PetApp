import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/comment/comment_entity.dart';
import '../../../domain/usecases/firebase_usecases/comment/create_comment_usecase.dart';
import '../../../domain/usecases/firebase_usecases/comment/delete_comment_usecase.dart';
import '../../../domain/usecases/firebase_usecases/comment/like_comment_usecase.dart';
import '../../../domain/usecases/firebase_usecases/comment/read_comment_usecase.dart';
import '../../../domain/usecases/firebase_usecases/comment/update_comment_usecase.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final LikeCommentUseCase likeCommentUseCase;
  final ReadCommentUseCase readCommentUseCase;
  final UpdateCommentUseCase updateCommentUseCase;
  CommentCubit({
    required this.updateCommentUseCase,
    required this.readCommentUseCase,
    required this.likeCommentUseCase,
    required this.deleteCommentUseCase,
    required this.createCommentUseCase
  }) : super(CommentInitial());

  Future<void> getComments({required String postId}) async {
    emit(CommentLoading());
    try {
      final streamResponse = readCommentUseCase.call(postId);
      streamResponse.listen((comments) {
        emit(CommentLoaded(comments: comments));
      });
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> likeComment({required CommentEntity comment}) async {
    try {
      await likeCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> deleteComment({required CommentEntity comment}) async {
    try {
      await deleteCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> createComment({required CommentEntity comment}) async {
    try {
      await createCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> updateComment({required CommentEntity comment}) async {
    try {
      await updateCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }
}