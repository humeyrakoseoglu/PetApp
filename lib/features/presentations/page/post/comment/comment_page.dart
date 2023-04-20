import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/features/presentations/page/post/comment/widgets/comment_main_widget.dart';

import '../../../../domain/entities/app_entity.dart';
import '../../../cubit/comment/comment_cubit.dart';
import 'package:pet/injection_container.dart' as di;

import '../../../cubit/post/get_single_post/get_single_post_cubit.dart';
import '../../../cubit/user/get_single_user/get_single_user_cubit.dart';

class CommentPage extends StatelessWidget {
  final AppEntity appEntity;

  const CommentPage({Key? key, required this.appEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommentCubit>(
          create: (context) => di.sl<CommentCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider<GetSinglePostCubit>(
          create: (context) => di.sl<GetSinglePostCubit>(),
        ),
      ],
      child: CommentMainWidget(appEntity: appEntity),
    );
  }
}