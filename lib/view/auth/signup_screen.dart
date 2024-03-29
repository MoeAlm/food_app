
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/view/home/main_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../core/components/text_components.dart';
import '../../core/components/textformfield.dart';
import '../../core/constants/constant.dart';
import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';
import '../../helper/shared_preferences.dart';
import '../../helper/show_snackbar.dart';
import 'login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  bool isVisible = true;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<FoodCubit, AppState>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var cubit = FoodCubit.get(context);
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: width * 0.07, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
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
                    child: StreamBuilder<QuerySnapshot>(
                        stream: cubit.images.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: width * 0.23,
                                          backgroundImage: NetworkImage(
                                              '${snapshot.data?.docs[index]['image']}'),
                                        ),
                                        Positioned(
                                          top: width * 0.35,
                                          left: width * 0.32,
                                          child: CircleAvatar(
                                            backgroundColor: kPrimaryColor,
                                            radius: width * 0.05,
                                            child: IconButton(
                                              onPressed: () async {
                                                await cubit.uploadImage();
                                              },
                                              icon: Icon(
                                                Icons
                                                    .mode_edit_outline_outlined,
                                                color: Colors.white,
                                                size: width * 0.04,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    defaultTextFormField(
                                      label: 'Name',
                                      inputType: TextInputType.emailAddress,
                                      hint: 'Enter your Name',
                                      onChanged: (text) {
                                        cubit.name = text;
                                      },
                                    ),
                                    defaultTextFormField(
                                      label: 'Email',
                                      inputType: TextInputType.emailAddress,
                                      hint: 'Enter your Email',
                                      onChanged: (text) {
                                        cubit.email = text;
                                      },
                                    ).py8(),
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
                                        cubit.password = text;
                                      },
                                    ).pOnly(bottom: height * 0.02),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: width * 0.5,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              //اوبجكت لـ FirebaseAuth
                                              if (formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                try {
                                                  await cubit.registerUser(
                                                      name: cubit.name);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                      return const MainScreen();
                                                    }),
                                                  );
                                                  CacheHelper.setData(
                                                      key: 'Auth',
                                                      value: cubit.email!);
                                                  cubit.images
                                                      .add({'id': cubit.email});
                                                } on FirebaseAuthException catch (e) {
                                                  if (e.code ==
                                                      "email-already-in-use") {
                                                    showSnackBar(context,
                                                        text:
                                                            'Email is Already exit');
                                                  } else if (e.code ==
                                                      "weak-password") {
                                                    showSnackBar(context,
                                                        text: 'Weak password');
                                                  }
                                                } catch (e) {
                                                  showSnackBar(context,
                                                      text:
                                                          'There was an error');
                                                }
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                                backgroundColor: kPrimaryColor,
                                                foregroundColor: Colors.white),
                                            child: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  fontSize: width * 0.05),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).pOnly(bottom: height * 0.12),
                                    buildText(
                                      width,
                                      text: 'Or via social media',
                                      size: 0.04,
                                      color: Colors.black54,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Already have an account?',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                return const LogIn();
                                              }),
                                            );
                                          },
                                          child: const Text(' Log In'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                ],
              ).p(16),
            ),
          );
        });
  }
}
