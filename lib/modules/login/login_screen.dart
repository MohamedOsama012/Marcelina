import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcelina/shared/components/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignInSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 350,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.brown
              ),
              child:  Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment:
                      isSignInSelected ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        width: 175,
                        height: 70,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignInSelected = true;
                              });
                            },
                            child: const Center(
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignInSelected = false;
                              });
                            },
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
