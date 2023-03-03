import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/components/text_components.dart';
import 'package:food_app_api/core/cubit/cubit.dart';
import 'package:food_app_api/core/cubit/states.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/model/food_model.dart';

class FavouriteFood extends StatelessWidget {
  const FavouriteFood({Key? key}) : super(key: key);

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
                text: 'Favourite',
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
            itemCount: cubit.likedIndex.length,
            itemBuilder: (BuildContext context, int index) {
              return favouriteItem(height, width,
                  model: cubit.likedIndex[index], onPressed: () {
                cubit.removeItem(index);
              }).pOnly(top: 12).px12();
            },
          ),
        );
      },
    );
  }

  Widget favouriteItem(double height, double width,
      {required Food model, required Function() onPressed}) {
    return Card(
      color: Colors.white,
      child: Container(
        height: height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              model.img,
              height: height * 0.3,
              width: width * 0.3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(width,
                    text: model.title,
                    size: 0.065,
                    color: Colors.black,
                    weight: FontWeight.w600),
                buildText(width,
                    text: model.subTitle,
                    size: 0.05,
                    color: Colors.black45,
                    weight: FontWeight.w600),
                buildText(
                  width,
                  text: '\$${model.price}',
                  size: 0.08,
                  color: Colors.black45,
                  weight: FontWeight.w600,
                ),
              ],
            ).py12(),
            IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
