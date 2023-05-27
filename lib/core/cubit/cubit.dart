
import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_api/core/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:food_app_api/view/home/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../view/fav_food_screen.dart';
import '../model/category_model.dart';
import '../model/food_model.dart';

class FoodCubit extends Cubit<AppState> {
  FoodCubit() : super(InitialState());

  static FoodCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int indexOfCategories = 0;
  double ratingCount = 0;
  int priceCount = 1;
  int? favIndex;
  int count = 0;
  bool isLiked = false;
  bool isVisible = true;
  var likedItems = [];
  var cartItems = [];
  var cartIndex = [];

  ////////////////////////////////////////
  String? email, password, name, displayedName;
  String imageUrl = 'assets/images/profile.jpg';
  XFile? pickedFile;
  ////////////////////////////////////////
  FirebaseStorage storage = FirebaseStorage.instance;
  var user = FirebaseAuth.instance.currentUser;
  TextEditingController? nameController, userController, passwordController = TextEditingController();
  ////////////////////////////////////////
  List<IconData> icons = [
    Icons.home_outlined,
    Icons.favorite_outline_rounded,
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
  List screens = [const HomeScreen(), const ItemsScreen()];


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
    count = cartItems.length;
    emit(ItemCountState());
    return count;
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
  updateName() {
    name = nameController?.text;
    emit(UpdateProfileState());
    return user?.updateDisplayName(name);
  }

  ////////////////////////////////////////

  Future<File?> selectPhoto(BuildContext context) async {
    final imagePicker = ImagePicker();

    final pickedSource = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
          ).p8(),
        );
      },
    );

    if (pickedSource != null) {
      pickedFile = await imagePicker.pickImage(source: pickedSource);
      if (pickedFile != null) {
        return File(pickedFile!.path);
      }
    }

    return null; // Return null if no image is selected
  }
  Future<String?> uploadImage(File imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final destination = 'images/$fileName';
      final ref = storage.ref(destination);
      await ref.putFile(imageFile);
      imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

}
