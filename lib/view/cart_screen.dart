import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/favourite_components.dart';
import '../core/cubit/cubit.dart';
import '../core/cubit/states.dart';
import 'detail_screen.dart';

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
          body: ListView.builder(
            itemCount: cubit.cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
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
                child: favouriteItem(height, width,
                    model: cubit.cartItems[index], onPressed: () {
                  cubit.removeItem(index, cubit.cartItems);
                }).pOnly(top: 12).px12(),
              );
            },
          ),
        );
      },
    );
  }
}
