import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/const.dart';
import 'package:pet/features/domain/entities/user/user_entity.dart';
import 'package:pet/features/presentations/page/credential/sign_in_page.dart';
import 'package:pet/features/presentations/page/credential/sign_up_page.dart';
import 'package:pet/features/presentations/page/post/comment/comment_page.dart';
import 'package:pet/features/presentations/page/post/update_post_page.dart';
import 'package:pet/features/presentations/page/profile/edit_profile_page.dart';

import 'features/domain/entities/app_entity.dart';
import 'features/domain/entities/comment/comment_entity.dart';
import 'features/domain/entities/posts/post_entity.dart';
import 'features/presentations/page/post/comment/edit_comment_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.editProfilePage:
        {
          if(args is UserEntity){
            return routeBuilder(EditProfilePage(currentUser: args,));
          }else{
            return routeBuilder(NoPageFound());
          }
        }
      case PageConst.updatePostPage: {
        if (args is PostEntity) {
          return routeBuilder(UpdatePostPage(post: args,));

        } else {
          return routeBuilder(NoPageFound());
        }
      }
      case PageConst.commentPage: {
        if (args is AppEntity) {
          return routeBuilder(CommentPage(appEntity: args,));
        }
        return routeBuilder(NoPageFound());
      }
      case PageConst.updateCommentPage: {
        if (args is CommentEntity) {
          return routeBuilder(EditCommentPage(comment: args,));

        } else {
          return routeBuilder(NoPageFound());
        }
      }
      case PageConst.signInPage: {
        return routeBuilder(SignInPage());
      }
      case PageConst.signUpPage: {
        return routeBuilder(SignUpPage());
      }
      case PageConst.signUpPage: {
        return routeBuilder(SignUpPage());
      }
      default : {
        NoPageFound();
      }
    }
  }
}
  dynamic routeBuilder(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  }

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page not found"),
      ),
      body: Center(child: Text("Page not found"),),
    );
  }
}
