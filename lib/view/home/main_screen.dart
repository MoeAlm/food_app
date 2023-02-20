import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/view/home/search_layout.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../core/cubit/cubit.dart';
import '../../core/cubit/states.dart';
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
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset('assets/images/profile.jpg'),
                ),
              ).px(6),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  key.currentState?.openEndDrawer();
                },
                icon: Image.asset(
                  'assets/icons/menu.png',
                  width: width * 0.09,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
              ).px4()
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
          endDrawer: MyDrawer(),
        );
      },
    );
  }
}
