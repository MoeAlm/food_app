import 'package:flutter/material.dart';
import 'package:food_app_api/view/auth/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/components/text_components.dart';
import '../../core/constants/constant.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: buildText(
          width,
          text: 'Food App',
          size: 0.075,
          color: Colors.black,
          weight: FontWeight.w700,
        ),
      ),
      body: Column(
        children: [
          Image.asset('assets/images/food_register.png')
              .pSymmetric(v: 40, h: 64),
          Text(
            'Hello!',
            style: GoogleFonts.dancingScript(
                fontSize: width * 0.17, fontWeight: FontWeight.bold),
          ),
          // buildText(
          //   width,
          //   text: 'Hello!',
          //   size: 0.09,
          //   color: Colors.black,
          //   weight: FontWeight.bold,
          // ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt',
            textAlign: TextAlign.center,
          ).pSymmetric(v: 20, h: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.35,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LogIn()));
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white),
                  child: Text(
                    'LogIn',
                    style: TextStyle(fontSize: width * 0.045),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.35,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: width * 0.045),
                  ),
                ),
              ),
            ],
          ).px(50),
          Align(
            alignment: Alignment.center,
            child: buildText(
              width,
              text: 'Or via social media',
              size: 0.04,
              color: Colors.black54,
            ).pOnly(top: 16),
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
        ],
      ),
    );
  }
}
