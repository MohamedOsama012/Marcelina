import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcelina/layouts/cubit/states.dart';
import 'package:marcelina/models/user_model.dart';
import 'package:marcelina/modules/home/home_scren.dart';
import 'package:marcelina/modules/profile/profile_screen.dart';
import 'package:marcelina/shared/components/constants.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  final List<String> categories = [
    "Marcelina",
    "Category 1",
    "Category 2",
    "Category 3",
    "Category 4",
  ];

  final List<Map<String, dynamic>> products = [
    {
      "title": "Letraset Perfume",
      "subTitle": "Publishing software",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 45.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 78.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Letraset Perfume",
      "subTitle": "Publishing software",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 45.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 78.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 78.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 78.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 78.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Letraset Perfume",
      "subTitle": "Publishing software",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 45.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 78.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 78.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 78.00,
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
      "price": 78.00,
      "imagePath": 'assets/images/logo.jpg',
    },
  ];

  int selectedCategoryIndex = 0;

  void changeCategory(int index) {
    selectedCategoryIndex = index;
    emit(AppChangeCategoryState());
  }

  int currentBottomIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    ProfileScreen()
  ];

  final List<String> title = [
    'Home',
    'Profile'
  ];

  void changeBottom(int index){
    currentBottomIndex = index;
    emit(AppChangeBottomState());
  }

  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> product) {
    int index = cartItems.indexWhere((item) => item['title'] == product['title']);
    if (index != -1) {
      cartItems[index]['quantity']++;
    } else {
      cartItems.add({...product, 'quantity': 1});
    }
    emit(AppCartUpdatedState());
  }

  void increaseQuantity(int index) {
    cartItems[index]['quantity']++;
    emit(AppCartUpdatedState());
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    }
    emit(AppCartUpdatedState());
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
    emit(AppCartUpdatedState());
  }

  double getTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + (item["price"] * item["quantity"]));
  }

  UserModel? userModel;

  void getUserData(){
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          userModel = UserModel.fromJson(value.data());
          emit(AppGetUserSuccessState());
        })
        .catchError((error){
          emit(AppGetUserErrorState(error.toString()));
        });
  }


}