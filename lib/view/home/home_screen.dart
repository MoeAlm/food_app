import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/view/detail_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../components/category_components.dart';
import '../../components/food_components.dart';
import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';
import '../view_all_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int indexOfPageView = 0;

  @override
  void initState() {
    super.initState();

    /// For Changing Index of Page View Automatically
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (indexOfPageView < 4) {
        indexOfPageView++;
        pageController.animateToPage(
          indexOfPageView,
          duration: const Duration(milliseconds: 350),
          curve: Curves.ease,
        );
      } else {
        indexOfPageView = -1;
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<FoodCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FoodCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.19,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.3),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black
                                    ],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/banner.jpg'),
                                    fit: BoxFit.cover,
                                ),
                            ),
                            child: SizedBox(
                              width: width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Let\'s find',
                                    style: TextStyle(
                                        fontSize: width * 0.09,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'food near you',
                                    style: TextStyle(
                                        fontSize: width * 0.09,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ).px(12).py12(),
                            ),
                          ).p(12);
                        }),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 5,
                        effect: WormEffect(
                            spacing: width * 0.013,
                            dotHeight: height * 0.015,
                            dotWidth: width * 0.03,
                            activeDotColor: Colors.orange,
                            dotColor: Vx.gray200),
                        onDotClicked: (value) {
                          pageController.animateToPage(value,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                      )).pOnly(bottom: 12),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black54,
                          size: height * 0.04,
                        ),
                        suffixIcon: Icon(Icons.filter_alt_outlined,
                            color: Colors.black54, size: height * 0.04),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        )),
                  ).px(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                            fontSize: width * 0.07,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ).px12().pOnly(top: 8),
                  SizedBox(
                    height: height * 0.143,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.category.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              cubit.changeIndexOfCategories(index);
                            },
                            child: categoryItem(
                              height,
                              width,
                              model: cubit.category[index],
                              color: cubit.indexOfCategories == index
                                  ? Colors.orange
                                  : Colors.grey.shade200,
                            ).pOnly(top: 12),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Food',
                        style: TextStyle(
                            fontSize: width * 0.07,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        child: Text(
                          'View All',
                          style: TextStyle(
                              fontSize: width * 0.05, color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ViewAll();
                          }));
                        },
                      ),
                    ],
                  ).px16().pOnly(top: 8, bottom: 12),
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisExtent: width * 0.65),
                      itemCount: cubit.food.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: foodItem(
                            height,
                            width,
                            model: cubit.food[index],
                            onPressed: () {
                              cubit.liked();
                              cubit.likedItems.add(cubit.food[index]);
                            },
                            icon: cubit.isLiked
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: width * 0.09,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    size: width * 0.09,
                                  ),
                          ).px(5),
                          onTap: () {
                            cubit.priceCount = 1;
                            cubit.ratingCount = 0;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  model: cubit.food[index],
                                  index: index,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
