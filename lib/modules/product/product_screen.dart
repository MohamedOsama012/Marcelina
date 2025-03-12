import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcelina/layouts/cubit/cubit.dart';
import 'package:marcelina/shared/styles/color.dart';

class ProductScreen extends StatelessWidget {
  final String title;
  final String subTitle;
  final double price;
  final String imagePath;

  const ProductScreen({
    required this.title,
    required this.subTitle,
    required this.price,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imagePath, width: double.infinity, height: 250, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
             Text(
              subTitle,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Spacer(),
            Text(
              "\$${price.toStringAsFixed(2)}",
              style:  TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  BlocProvider.of<AppCubit>(context).addToCart({
                    "title": title,
                    "price": price,
                    "imagePath": imagePath,
                  });
                },
                child: const Text("Add to Bag", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}