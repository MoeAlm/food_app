import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/components/text_components.dart';
import 'package:food_app_api/core/cubit/cubit.dart';
import 'package:food_app_api/core/cubit/states.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/favourite_components.dart';
import 'detail_screen.dart';

class ItemsScreen extends StatelessWidget {
  final String text;
  final list;

  const ItemsScreen({super.key, required this.text, required this.list});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, AppState>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var cubit = FoodCubit.get(context);
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: AppBar(
            title: buildText(width,
                text: text,//'Favourite'*/,
                size: 0.08,
                color: Colors.black,
                weight: FontWeight.w800),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        model: list[index], index: index,
                      ),
                    ),
                  );
                },
                child: favouriteItem(height, width,
                    model: list[index], onPressed: () {
                  cubit.removeItem(index, list);
                }).pOnly(top: 12).px12(),
              );
            },
          ),
        );
      },
    );
  }
}
