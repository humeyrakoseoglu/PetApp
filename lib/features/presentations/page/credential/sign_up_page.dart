import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet/const.dart';
import 'package:pet/features/domain/entities/user/user_entity.dart';
import 'package:pet/features/presentations/cubit/auth/auth_cubit.dart';
import 'package:pet/features/presentations/cubit/credential/credential_cubit.dart';
import 'package:pet/features/presentations/page/credential/sign_in_page.dart';
import 'package:pet/features/presentations/page/main_screen/main_screen.dart';

import '../../widgets/button_container_widget.dart';
import '../../widgets/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  bool _isSigningUp = false;
  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
      if (credentialState is CredentialSuccess) {
        BlocProvider.of<AuthCubit>(context).loggedIn(context);
      }
      if (credentialState is CredentialFailure) {
        toast("Invalid Email and Password");
      }
    },
    builder: (context, credentialState) {
      if (credentialState is CredentialSuccess) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Authenticated) {
               return MainScreen(uid: authState.uid);
            } else {
              return _bodyWidget();
            }
            },
        );
      }
      return _bodyWidget();
      },
        )
    );
  }

  _bodyWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          // Center(
          //   child: Image.asset("assets/profile_default.png"),

          // ),
          SizedBox(height: 15),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Image.asset("assets/profile_default.png"),
                ),
                Positioned(
                  right: -10,
                  bottom: -15,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_a_photo, color: blueColor,),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          FormContainerWidget(
            controller: _userNameController ,
            hintText: "Username",
          ),
          SizedBox(height: 15),
          FormContainerWidget(
            controller: _emailController ,
            hintText: "Email",
          ),
          SizedBox(height: 15),
          FormContainerWidget(
            controller: _passwordController ,
            hintText: "Password",
            isPasswordField: true,
          ),
          SizedBox(height: 15),
          FormContainerWidget(
            controller: _bioController ,
            hintText: "Bio",
          ),
          SizedBox(height: 15),
          ButtonContainerWidget(
            color: blueColor,
            text: "Sign Up",
            onTapListener: () {
              _signUpUser();
            },
          ),
          sizeVer(10),
          _isSigningUp == true ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please wait", style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.w400),),
              sizeHor(10),
              CircularProgressIndicator()
            ],
          ) : Container(width: 0, height: 0,),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Divider(
            color: secondaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? ", style: TextStyle(color: primaryColor),),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false);

                  //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInPage()), (route) => false);
                },
                child:  Text(
                  "Sign In.",
                  style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  void _signUpUser() {
    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context).signUpUser(
       UserEntity(email: _emailController.text,
       password: _passwordController.text,
       bio: _bioController.text,
       username: _userNameController.text,
       totalPosts: 0,
       totalFollowing: 0,
       followers: [],
       totalFollowers: 0,
       profileUrl: "",
       website: "",
       following: [],
       name: "",
      )
    ).then((value) => _clear());
  }
  _clear(){
    setState(() {
      _userNameController.clear();
      _bioController.clear();
      _passwordController.clear();
      _emailController.clear();
      _isSigningUp = false;
    });
  }
}


