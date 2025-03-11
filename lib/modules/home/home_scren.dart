import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marcelina/layouts/cubit/cubit.dart';
import 'package:marcelina/layouts/cubit/states.dart';
import 'package:marcelina/shared/components/components.dart';
import 'package:marcelina/shared/styles/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {  },
      builder: (BuildContext context, AppStates state) {
        final cubit = AppCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cubit.categories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = cubit.selectedCategoryIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: TextButton(
                        onPressed: () {
                          cubit.changeCategory(index);
                        },
                        child: Text(
                          cubit.categories[index],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isSelected ? Colors.black : primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: cubit.products.length,
                itemBuilder: (context, index) {
                  return buildProductCard(
                    title: cubit.products[index]["title"]!,
                    subTitle: cubit.products[index]["subTitle"]!,
                    price: cubit.products[index]["price"]!,
                    imagePath: cubit.products[index]["imagePath"]!,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
