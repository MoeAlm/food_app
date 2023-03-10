import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/view/home/search_layout.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:badges/badges.dart' as badges;

import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';
import '../fav_food_screen.dart';
import '../profile.dart';
import 'drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

    return BlocConsumer<FoodCubit, AppState>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var cubit = FoodCubit.get(context);
        return Scaffold(
          key: key,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ProfileScreen();
                    },
                  ),
                );
              },
              child: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Hero(
                      tag: 'profile',
                      child: Image.asset('assets/images/profile.jpg')),
                ),
              ).px(6),
            ),
            actions: [
              InkWell(
                onTap: (){},
                child: badges.Badge(
                  badgeContent: Text('3', style: TextStyle(color: Colors.white),),
                  child: Icon(Icons.shopping_cart_outlined, size: width * 0.08,),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const FavouriteFood(text: 'Favourite',);
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.favorite_outline,
                  size: width * 0.08,
                ),
              ).pOnly(left: 8),
              IconButton(
                onPressed: () {
                  key.currentState?.openEndDrawer();
                },
                icon: Image.asset(
                  'assets/icons/menu.png',
                  width: width * 0.08,
                  height: height * 0.04,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
              ).px4(),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchLayout()));
            },
            backgroundColor: Colors.orange,
            child: Image.asset(
              'assets/icons/loupe.png',
              height: height * 0.09,
              width: width * 0.09,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            gapLocation: GapLocation.center,
            icons: cubit.icons,
            activeColor: Colors.orange,
            activeIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeIndex(value);
            },
            iconSize: width * 0.08,
          ),
          endDrawer: const MyDrawer(),
        );
      },
    );
  }
}
