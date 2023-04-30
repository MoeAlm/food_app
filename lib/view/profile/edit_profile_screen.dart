import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/core/constants/constant.dart';
import 'package:food_app_api/core/cubit/cubit.dart';
import 'package:food_app_api/core/cubit/states.dart';

import '../../components/edit_profile_components.dart';

class EditProfileScreen extends StatelessWidget {
  String? imageUrl;

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<FoodCubit, AppState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = FoodCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: TextStyle(
                  fontSize: width * 0.07, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: kPrimeryColor,
                size: width * 0.085,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: kPrimeryColor,
                  size: width * 0.09,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      child:
                          Image.asset(imageUrl ?? 'assets/images/profile.jpg'),
                    ),
                    Positioned(
                      top: width * 0.29,
                      left: width * 0.26,
                      child: CircleAvatar(
                        backgroundColor: kPrimeryColor,
                        radius: width * 0.04,
                        child: IconButton(
                          onPressed: () {
                            cubit.selectPhoto(context);
                          },
                          icon: Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Colors.white,
                            size: width * 0.04,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                buildListTile(width, height,
                    text: 'Full Name',
                    hint: 'Full Name',
                    controller: cubit.nameController),
                buildListTile(width, height,
                    text: 'Username',
                    hint: 'Username',
                    controller: cubit.userController),
                buildListTile(width, height,
                    text: 'Password',
                    hint: 'Password',
                    iconButton: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility),
                    ),
                    controller: cubit.passwordController),
                buildListTile(width, height,
                    text: 'Location', hint: 'Location'),
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * 0.35,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black),
                        child: const Text('CANCEL'),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.35,
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.name = cubit.nameController.text;
                          cubit.updateName();
                          Navigator.pop(context);
                          //cubit.user?.updatePassword(_passwordController.text);
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: kPrimeryColor,
                            foregroundColor: Colors.white),
                        child: const Text('SAVE'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
