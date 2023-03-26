import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet/const.dart';
import 'package:pet/features/presentations/page/credential/sign_in_page.dart';

import '../../widgets/button_container_widget.dart';
import '../../widgets/form_container_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Padding(
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
              hintText: "Username",
            ),
            SizedBox(height: 15),
            FormContainerWidget(
              hintText: "Email",
            ),
            SizedBox(height: 15),
            FormContainerWidget(
              hintText: "Password",
              isPasswordField: true,
            ),
            SizedBox(height: 15),
            FormContainerWidget(
              hintText: "Bio",
            ),
            SizedBox(height: 15),
            ButtonContainerWidget(
              color: blueColor,
              text: "Sign Up",
              onTapListener: () {},
            ),
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
            )
          ],
        ),
      ),
    );
  }
}