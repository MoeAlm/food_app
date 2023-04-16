import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_api/view/register/signup_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/text_components.dart';
import '../../core/components/textformfield.dart';
import '../../core/constants/constant.dart';
import '../../helper/show_snackbar.dart';
import '../home/main_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? email;

  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: buildText(
            width,
            text: 'Food App',
            size: 0.075,
            color: Colors.black,
            weight: FontWeight.w700,
          ),
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/food_register.png',
                  width: width,
                  height: height * 0.5,
                ),
              ),
            ).pOnly(top: height * 0.1),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                        fontSize: width * 0.09, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                        fontSize: width * 0.04, color: Colors.black54),
                  ).pOnly(bottom: height * 0.08),
                  defaultTextFormField(
                    label: 'Username',
                    inputType: TextInputType.emailAddress,
                    hint: 'Enter your username',
                    onChanged: (text) {
                      email = text;
                    },
                  ),
                  defaultTextFormField(
                    label: 'Password',
                    inputType: TextInputType.visiblePassword,
                    hint: 'Enter your password',
                    iconButton: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    obscureText: isVisible,
                    onChanged: (text) {
                      password = text;
                    },
                  ).py8(),
                  SizedBox(
                    height: height * 0.00,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(
                          width: width * 0.5,
                          child: ElevatedButton(
                            onPressed: () async {
                              //اوبجكت لـ FirebaseAuth
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await loginUser();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const MainScreen();
                                  }));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == "user-not-found") {
                                    showSnackBar(context,
                                        text: 'Email is Already exit');
                                  } else if (e.code == "wrong-password") {
                                    showSnackBar(context,
                                        text: 'Wrong password');
                                  }
                                } catch (e) {
                                  showSnackBar(context,
                                      text: 'There was an error');
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: kPrimeryColor,
                                foregroundColor: Colors.white),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: width * 0.05),
                            ),
                          ),
                        ).pOnly(bottom: height * 0.01),
                      ],
                    ),
                  ).pOnly(bottom: height * 0.22),
                  Align(
                    alignment: Alignment.center,
                    child: buildText(
                      width,
                      text: 'Or via social media',
                      size: 0.04,
                      color: Colors.black54,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        'assets/icons/social/facebook.png',
                        width: width * 0.1,
                      ),
                      Image.asset(
                        'assets/icons/social/google.png',
                        width: width * 0.1,
                      ),
                      Image.asset(
                        'assets/icons/social/linkedin.png',
                        width: width * 0.1,
                      ),
                    ],
                  ).px(width * 0.2).py16(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account?',
                        style: TextStyle(color: Colors.black54),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const SignUp();
                            }),
                          );
                        },
                        child: const Text(' Sign up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ).p(16),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
