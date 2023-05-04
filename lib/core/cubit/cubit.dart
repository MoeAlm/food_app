
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/core/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:food_app_api/view/home/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../view/cart_screen.dart';
import '../model/category_model.dart';
import '../model/food_model.dart';

class FoodCubit extends Cubit<AppState> {
  FoodCubit() : super(InitialState());

  static FoodCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int indexOfCategories = 0;
  double ratingCount = 0;
  int priceCount = 1;
  int count = 0;
  bool isLiked = false;
  bool isVisible = true;
  var likedItems = [];
  var cartItems = [];
  var cartIndex = [];

  ////////////////////////////////////////
  String? email;
  String? password;
  String? name;
  String imageUrl = 'assets/images/profile.jpg';
  ////////////////////////////////////////
  var user = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  ////////////////////////////////////////
  List<IconData> icons = [
    Icons.home_outlined,
    Icons.shopping_bag_outlined,
  ];
  List<Food> food = [
    Food(
        img: 'assets/images/food/1.png',
        title: 'Shish Kebab',
        subTitle: 'shish kebab',
        price: 12.99,
        id: 1),
    Food(
        img: 'assets/images/food/2.png',
        title: 'Pizza',
        subTitle: 'California-style',
        price: 12.50,
        id: 2),
    Food(
        img: 'assets/images/food/3.png',
        title: 'Hamburger',
        subTitle: 'Hamburger',
        price: 7.99,
        id: 3),
    Food(
        img: 'assets/images/food/4.png',
        title: 'Mozzarella sticks',
        subTitle: 'Mozzarella sticks',
        price: 5.99,
        id: 4),
    Food(
        img: 'assets/images/food/5.png',
        title: 'Chicken nugget',
        subTitle: 'Chicken nugget',
        price: 12.99,
        id: 5),
    Food(
        img: 'assets/images/food/6.png',
        title: 'Cheese fries',
        subTitle: 'Cheese fries',
        price: 12.99,
        id: 6),
  ];
  List<CategoryModel> category = [
    CategoryModel(icon: 'assets/icons/category/dish.png', title: 'All'),
    CategoryModel(
        icon: 'assets/icons/category/fast_food.png', title: 'Fast Food'),
    CategoryModel(icon: 'assets/icons/category/lobster.png', title: 'Sea Food'),
    CategoryModel(icon: 'assets/icons/category/cake.png', title: 'Cakes'),
    CategoryModel(icon: 'assets/icons/category/spaghetti.png', title: 'Meals'),
  ];
  List screens = [const HomeScreen(), const CartScreen()];

  ////////////////////////////////////////
  void changeIndex(index) {
    currentIndex = index;
    emit(BottomNavChanges());
  }

  ////////////////////////////////////////
  void changeIndexOfCategories(index) {
    indexOfCategories = index;
    emit(CategoryChanges());
  }

  ////////////////////////////////////////
  void ratingBarChange(value) {
    ratingCount = value;
    emit(RatingBarChanges());
  }

  ////////////////////////////////////////
  void plusCount() {
    priceCount++;
    emit(PlusItemChanges());
  }

  ////////////////////////////////////////
  void minusCount() {
    if (priceCount > 0) {
      priceCount--;
      emit(MinusItemChanges());
    }
    emit(MinusItemChanges());
  }

  ////////////////////////////////////////
  void liked() {
    isLiked = !isLiked;
    emit(LikeState());
  }

  ////////////////////////////////////////
  void removeItem(index, item) {
    item.removeAt(index);
    emit(RemoveState());
  }

  ////////////////////////////////////////
  itemNumber() {
    emit(ItemCountState());
    count = cartItems.length;
    emit(ItemCountState());
  }

  ////////////////////////////////////////
  void convertValue() {
    isVisible = !isVisible;
    emit(ChangeState());
  }

  ////////////////////////////////////////
  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  ////////////////////////////////////////
  Future<void> registerUser({required name}) async {
    var user = FirebaseAuth.instance;
    await user
        .createUserWithEmailAndPassword(email: email!, password: password!);
    user.currentUser?.updateDisplayName(name);

  }
  void updateName() {
    user?.updateDisplayName(name);
    emit(UpdateProfileState());
  }

  ////////////////////////////////////////
  Future selectPhoto(context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    imagePicker.pickImage(source: ImageSource.camera).then((value) {
                      imageUrl = value.toString();
                      emit(UpdateProfileState());
                    });
                    emit(UpdateProfileState());
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text('Gellary'),
                  onTap: () {
                    Navigator.pop(context);
                    imagePicker.pickImage(source: ImageSource.gallery);
                  },
                ),
              ],
            ).p8(),
          );
        });
  }
}
