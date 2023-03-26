import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet/features/presentations/page/credential/sign_in_page.dart';
import 'package:pet/features/presentations/page/main_screen/main_screen.dart';
import 'on_generate_route.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram Clone",
      darkTheme: ThemeData.dark(),
      onGenerateRoute: OnGenerateRoute.route,
      initialRoute: "/",
      routes: {
        "/": (context) {
          return MainScreen();
        }
      },
    );
  }
}