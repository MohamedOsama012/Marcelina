import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcelina/layouts/cubit/states.dart';
import 'package:marcelina/modules/home/home_scren.dart';
import 'package:marcelina/modules/profile/profile_screen.dart';

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

  final List<Map<String, String>> products = [
    {
      "title": "Letraset Perfume",
      "subTitle": "Publishing software",
      "price": "\$45.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "price": "\$78.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Letraset Perfume",
      "subTitle": "Publishing software",
      "price": "\$45.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "price": "\$78.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "price": "\$78.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "price": "\$78.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "price": "\$78.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Letraset Perfume",
      "subTitle": "Publishing software",
      "price": "\$45.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "price": "\$78.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "price": "\$78.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "price": "\$78.00",
      "imagePath": 'assets/images/logo.jpg',
    },
    {
      "title": "Contrary to Popular",
      "subTitle": "Nostrud exercitation",
      "price": "\$78.00",
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
    const ProfileScreen()
  ];

  final List<String> title = [
    'Home',
    'Profile'
  ];

  void changeBottom(int index){
    currentBottomIndex = index;
    emit(AppChangeBottomState());
  }



}