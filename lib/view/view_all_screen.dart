import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/core/cubit/states.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/components/food_components.dart';
import '../core/components/text_components.dart';
import '../core/constants/constant.dart';
import '../core/cubit/cubit.dart';
import 'detail_screen.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, AppState>(
      listener: (context, index) {},
      builder: (context, index) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        var cubit = FoodCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: buildText(width, text: 'All Food', size: 0.07, color: Colors.black, weight: FontWeight.bold),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: kPrimaryColor,
                )),
          ),
          body: GridView.builder(
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: width * 0.65),
          ),
        );
      },
    );
  }
}
