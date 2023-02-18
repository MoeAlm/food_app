import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/view/detail_screen.dart';
import 'package:food_app_api/view/home/home_screen.dart';
import 'package:food_app_api/view/home/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/cubit/bloc_observer.dart';
import 'core/cubit/cubit.dart';
import 'core/cubit/states.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoodCubit(),
      child: BlocConsumer<FoodCubit, AppState>(
    listener: (context, state) {},
    builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark),
            ),
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.albertSansTextTheme(
              Theme.of(context).textTheme,
            ),
            iconTheme: const IconThemeData(
              color: Colors.black54,
            ),
          ),
          home: const MainScreen(),
        );
      }),
    );
  }
}
