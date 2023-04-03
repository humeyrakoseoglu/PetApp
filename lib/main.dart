import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/features/presentations/cubit/auth/auth_cubit.dart';
import 'package:pet/features/presentations/cubit/credential/credential_cubit.dart';
import 'package:pet/features/presentations/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:pet/features/presentations/cubit/user/user_cubit.dart';
import 'package:pet/features/presentations/page/credential/sign_in_page.dart';
import 'package:pet/features/presentations/page/main_screen/main_screen.dart';
import 'on_generate_route.dart';
import 'injection_container.dart' as di;


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(//Bu listede Cubitlere enjeksiyon kabında bulunan kayıtlı tiplerinden istekte bulunulur.
      providers: [ // uygulamamız başladığında tüm bu kübitleri talep edeceğiz
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "PET APP",
          darkTheme: ThemeData.dark(),
          onGenerateRoute: OnGenerateRoute.route,
          initialRoute: "/",
          routes: {
            "/": (context) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return MainScreen(uid: authState.uid,);
                  } else {
                    return SignInPage();
                  }
                },
              );
            }
          }
      ),
    );
  }
}