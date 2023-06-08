import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/view/chat_screen.dart';
import 'package:food_app_api/view/home/search_layout.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';
import '../cart_screen.dart';
import '../profile/profile.dart';
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
              child: Hero(
                tag: 'profile',
                child: CircleAvatar(
                  backgroundImage: AssetImage(cubit.imageUrl),
                ),
              ).px(6),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ChatScreen();
                      },
                    ),
                  );
                },
                child: Badge(
                  label: const Text(
                    '0',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Image.asset(
                    'assets/icons/chat.png',
                    width: width * 0.085,
                    color: Colors.black87,
                  ),
                ),
              ).pOnly(right: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const CartScreen();
                      },
                    ),
                  );
                },
                child: Badge(
                  label: Text(
                    '${cubit.count}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: Image.asset(
                    'assets/icons/cart.png',
                    width: width * 0.08,
                    color: Colors.black87,
                  ),
                ),
              ).pOnly(right: 10),
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
                  builder: (context) => const SearchLayout(),
                ),
              );
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
