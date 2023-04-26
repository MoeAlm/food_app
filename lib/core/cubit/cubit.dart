import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/core/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:food_app_api/view/home/home_screen.dart';
import '../../view/cart_screen.dart';
import '../model/category_model.dart';
import '../model/food_model.dart';

class FoodCubit extends Cubit<AppState> {
  FoodCubit() : super(InitialState());

  static FoodCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int indexOfCategories = 0;
  int indexOfPageView = 0;
  double ratingCount = 0;
  int priceCount = 1;
  int count = 0;
  bool isLiked = false;
  bool isVisible = true;
  var likedItems = [];
  var cartItems = [];
  ////////////////////////////////////////
  String? email;
  String? password;
  ////////////////////////////////////////
  var user = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ////////////////////////////////////////
  PageController pageController = PageController();
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
        price: 12.99),
    Food(
        img: 'assets/images/food/2.png',
        title: 'Pizza',
        subTitle: 'California-style',
        price: 12.50),
    Food(
        img: 'assets/images/food/3.png',
        title: 'Hamburger',
        subTitle: 'Hamburger',
        price: 7.99),
    Food(
        img: 'assets/images/food/4.png',
        title: 'Mozzarella sticks',
        subTitle: 'Mozzarella sticks',
        price: 5.99),
    Food(
        img: 'assets/images/food/5.png',
        title: 'Chicken nugget',
        subTitle: 'Chicken nugget',
        price: 12.99),
    Food(
        img: 'assets/images/food/6.png',
        title: 'Cheese fries',
        subTitle: 'Cheese fries',
        price: 12.99),
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
  Future<void> registerUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
