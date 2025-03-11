import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcelina/layouts/cubit/cubit.dart';
import 'package:marcelina/layouts/cubit/states.dart';
import 'package:marcelina/shared/styles/color.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Cart', style: TextStyle(color: Colors.black)),
          ),
          body: cubit.cartItems.isEmpty
              ? const Center(child: Text("Your cart is empty!", style: TextStyle(fontSize: 18)))
              : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cubit.cartItems[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Image.asset(item["imagePath"], width: 80, height: 80, fit: BoxFit.cover),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item["title"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text("\$${item["price"]}", style: TextStyle(fontSize: 14, color: primaryColor, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove, color: Colors.red),
                                        onPressed: () => cubit.decreaseQuantity(index),
                                      ),
                                      Text("${item["quantity"]}", style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: const Icon(Icons.add, color: Colors.green),
                                        onPressed: () => cubit.increaseQuantity(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.grey),
                              onPressed: () => cubit.removeItem(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Total: \$${cubit.getTotalPrice().toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                      child: const Text("Checkout", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}