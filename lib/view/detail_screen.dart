import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import '../core/cubit/cubit.dart';
import '../core/cubit/states.dart';
import '../core/model/food_model.dart';

class DetailsScreen extends StatelessWidget {
  final Food model;
  final int index;

  const DetailsScreen({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<FoodCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FoodCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Vx.gray50,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: model.img,
                  child: Container(
                    height: height * 0.33,
                    width: width,
                    decoration: BoxDecoration(
                        color: Vx.gray50,
                        image: DecorationImage(
                          image: AssetImage(model.img),
                        ),
                        borderRadius: const BorderRadiusDirectional.vertical(
                            bottom: Radius.circular(20))),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      '3 km',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ).pOnly(right: 5),
                    Container(
                      height: height * 0.009,
                      width: width * 0.018,
                      decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle // Change the box shape
                          ),
                    ),
                    const Text(
                      '15 min delivery',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ).pOnly(left: 5),
                  ],
                ).pOnly(top: 10, left: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.title,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/heart.png',
                          height: height * 0.035,
                          width: width * 0.07,
                        )),
                  ],
                ).px(8).py(10),
                Row(
                  children: [
                    RatingBar.builder(
                      itemSize: width * 0.05,
                      initialRating: 0,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        cubit.ratingBarChange(rating);
                      },
                    ),
                    Text(
                      '${cubit.ratingCount} Rating',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ).pOnly(left: 6)
                  ],
                ).px(8),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ).py12().px8(),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ).px8(),
                Container(
                  color: Vx.gray50,
                  width: width,
                  height: height * 0.2235,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price:',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${double.parse((model.price * cubit.priceCount).toStringAsFixed(2))}',
                            style: TextStyle(
                                fontSize: width * 0.07,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              FloatingActionButton.small(
                                heroTag: "btn1",
                                onPressed: () {
                                  cubit.plusCount();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                    side:
                                        const BorderSide(color: Colors.orange)),
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.orange,
                                splashColor: Colors.orange,
                                elevation: 0.0,
                                child: const Icon(Icons.add),
                              ),
                              Text(
                                '${cubit.priceCount}',
                                style: TextStyle(fontSize: width * 0.09),
                              ).px(4),
                              FloatingActionButton.small(
                                heroTag: "btn2",
                                onPressed: () {
                                  cubit.minusCount();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                    side:
                                        const BorderSide(color: Colors.orange),
                                ),
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.orange,
                                splashColor: Colors.orange,
                                elevation: 0.0,
                                child: const Icon(Icons.remove),
                              ),
                            ],
                          ).pOnly(bottom: 12)
                        ],
                      ).px12(),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width * 0.75,
                          child: ElevatedButton(
                            onPressed: () {
                              cubit.cartItems.add(cubit.food[index]);                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white),
                            child: const Text(
                              'Add To Cart',
                              style: TextStyle(fontSize: 23),
                            ),
                          ),
                        ),
                      )
                    ],
                  ).px8(),
                ).pOnly(top: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
