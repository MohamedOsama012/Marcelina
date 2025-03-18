import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:marcelina/layouts/cubit/cubit.dart';
import 'package:marcelina/layouts/cubit/states.dart';
import 'package:marcelina/modules/cart/cart_screen.dart';
import 'package:marcelina/shared/components/components.dart';
import 'package:marcelina/shared/styles/color.dart';
import 'package:marcelina/shared/styles/icon_broken.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          final cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: backgroundColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu)),
              title:  Text(
                cubit.title[cubit.currentBottomIndex],
                style: const TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  icon: const Icon(IconBroken.Bag),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),
              ],
            ),
            body: ConditionalBuilder(
                condition: cubit.userModel != null,
                builder: (context) => cubit.screens[cubit.currentBottomIndex],
                fallback: (context) => Center(child: CircularProgressIndicator(color: primaryColor,))
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: HexColor('#DD5D79'),
              currentIndex: cubit.currentBottomIndex,
              onTap: (index){
                cubit.changeBottom(index);
              },

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Profile),
                  label: 'Profile'
                ),
              ]
            ),
          );
        },
      );
  }
}
