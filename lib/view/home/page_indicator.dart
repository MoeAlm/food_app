import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';

Widget pageIndicator(double width, double height) {
  return BlocConsumer<FoodCubit, AppState>(
    listener: (BuildContext context, Object? state) {},
    builder: (BuildContext context, state) {
      var cubit = FoodCubit.get(context);
      return SmoothPageIndicator(
        controller: cubit.pageController,
        count: 5,
        effect: WormEffect(
            spacing: width * 0.013,
            dotHeight: height * 0.015,
            dotWidth: width * 0.03,
            activeDotColor: Colors.orange,
            dotColor: Vx.gray200),
        onDotClicked: (value) {
          cubit.pageController.animateToPage(value,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      );
    },
  );
}
