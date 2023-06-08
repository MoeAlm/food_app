import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/components/text_components.dart';
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
                onLongPress: () {
                  cubit.removeItem(index, cubit.cartItems);
                  cubit.itemNumber();
                },
                child: buildCart(width, height, model: cubit.cartItems[index],
                    onAdd: () {
                  cubit.plusCount();
                }, onRemove: () {
                  cubit.minusCount();
                }, priceCount: cubit.priceCount).px12(),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildCart(double width, double height,
      {required Food model,
      required Function() onAdd,
      required Function() onRemove,
      required priceCount,}) {
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
              width: width * 0.3,
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
                    text: '\$${(model.price * priceCount).toStringAsFixed(2)}',
                    size: 0.06,
                    color: kPrimaryColor,
                    weight: FontWeight.bold),
              ],
            ),
            Container(
              height: height * 0.2,
              width: width * 0.085,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  TextButton(
                      onPressed: onAdd,
                      child: buildText(width,
                          text: '+', size: 0.08, color: Colors.white)),
                  buildText(width, text: '${priceCount}', size: 0.06, color: Colors.white),
                  TextButton(
                    onPressed: onRemove,
                    child: buildText(width,
                        text: '-', size: 0.08, color: Colors.white),
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
