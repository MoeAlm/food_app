import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/firebase_options.dart';
import 'package:food_app_api/view/home/main_screen.dart';

import 'package:food_app_api/view/register/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/cubit/bloc_observer.dart';
import 'core/cubit/cubit.dart';
import 'core/cubit/states.dart';
import 'helper/shared_prefrences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
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
            var auth = CacheHelper.getData(key: 'Auth');
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
                    statusBarIconBrightness: Brightness.dark,
                  ),
                ),
                scaffoldBackgroundColor: Colors.white,
                textTheme: GoogleFonts.albertSansTextTheme(
                  Theme.of(context).textTheme,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.black54,
                ),
              ),
              home: auth == null? const RegisterScreen() : const MainScreen(),
            );
          }),
    );
  }
}
