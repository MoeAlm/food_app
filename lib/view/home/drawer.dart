import 'package:flutter/material.dart';
import 'package:food_app_api/components/text_components.dart';
import 'package:food_app_api/core/constants/constant.dart';
import 'package:velocity_x/velocity_x.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: height * 0.3,
              width: width,
              color: kPrimeryColor.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: CircleAvatar(
                      radius: width * 0.12,
                      child: Image.asset('assets/images/profile.jpg', width: width * 0.5, height: height * 0.6,),
                    ),
                  ).py12(),
                  buildText(width, text: 'Mohammed Almazouzi', size: 0.07, color: Colors.black54, weight: FontWeight.w700),
                  buildText(width, text: 'example@gmail.com', size: 0.07, color: Colors.black54).opacity50().pOnly(top: 2),
                ],
              ).p(20),
            ),
          ],
        ),
      ),
    );
  }
}
