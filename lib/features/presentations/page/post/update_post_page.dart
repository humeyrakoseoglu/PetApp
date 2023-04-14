import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/features/presentations/page/post/widget/update_post_widget.dart';

import '../../../domain/entities/posts/post_entity.dart';
import '../../cubit/post/post_cubit.dart';
import 'package:pet/injection_container.dart' as di;

class UpdatePostPage extends StatelessWidget {
  final PostEntity post;

  const UpdatePostPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: UpdatePostMainWidget( post: post,),
    );
  }
}
