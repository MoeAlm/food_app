import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/components/text_components.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/constants/constant.dart';
import '../core/cubit/cubit.dart';
import '../core/cubit/states.dart';
import '../core/model/food_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        var cubit = FoodCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
            ),
            title: Text(
              'Cart',
              style: TextStyle(
                  fontSize: width * 0.08, fontWeight: FontWeight.w900),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: cubit.cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
                child: buildCart(width, height, model: cubit.cartItems[index]).px12(),
                // child: favouriteItem(height, width,
                //     model: cubit.cartItems[index], onPressed: () {
                //   cubit.removeItem(index, cubit.cartItems);
                //   cubit.cartIndex.removeAt(index);
                // }).pOnly(top: 12).px12(),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildCart(double width, double height, {required Food model}) {
    return SizedBox(
                width: width,
                height: height * 0.2,
                child: Card(
                  elevation: 0.3,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        model.img,
                        width: width * 0.35,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildText(width,
                              text: model.title,
                              size: 0.06,
                              color: Colors.black,
                              weight: FontWeight.bold),
                          buildText(width,
                                  text: model.subTitle,
                                  size: 0.035,
                                  color: Colors.black12,
                                  weight: FontWeight.bold)
                              .py12(),
                          buildText(width,
                              text: '\$${model.price}',
                              size: 0.06,
                              color: kPrimeryColor,
                              weight: FontWeight.bold),
                        ],
                      ),
                      Container(
                        height: height * 0.2,
                        width: width * 0.09,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kPrimeryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: buildText(width,
                                    text: '+',
                                    size: 0.08,
                                    color: Colors.white)),
                            buildText(width,
                                text: '3', size: 0.065, color: Colors.white),
                            TextButton(
                                onPressed: () {},
                                child: buildText(width,
                                    text: '-',
                                    size: 0.08,
                                    color: Colors.white),
                            ),
                          ],
                        ),
                      ).p8()
                    ],
                  ),
                ),
              );
  }
}
