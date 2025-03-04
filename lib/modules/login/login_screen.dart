import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:marcelina/shared/components/components.dart';
import 'package:marcelina/shared/styles/color.dart';
import 'package:marcelina/shared/styles/icon_broken.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  bool _isSignInSelected = true;
  final _signInFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final _emailSignInController = TextEditingController();
  final _passwordSignInController = TextEditingController();
  final _emailRegisterController = TextEditingController();
  final _passwordRegisterController = TextEditingController();
  final _nameRegisterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#e3e3e1'),
      appBar: AppBar(
        backgroundColor: HexColor('#e3e3e1') ,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: HexColor('E2E8F0'),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: _isSignInSelected
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: 175,
                        height: 70,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _isSignInSelected = !_isSignInSelected;
                              });
                            },
                            behavior: HitTestBehavior.opaque,
                            child: SizedBox.expand(
                              child: Center(
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                    color: _isSignInSelected ?Colors.white:  primaryColor ,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _isSignInSelected = !_isSignInSelected;
                              });
                            } ,
                            behavior: HitTestBehavior.opaque,
                            child: SizedBox.expand(
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: _isSignInSelected ? primaryColor:  Colors.white ,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ...(
                  _isSignInSelected
                      ? [
                    Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 350,
                            child: CustomTextField(
                              controller: _emailSignInController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                // TODO
                              },
                              label: 'Email',
                              prefix: IconBroken.Message,
                            ),
                          ),
                          const SizedBox(height : 10),
                          SizedBox(
                            width: 350,
                            child: CustomTextField(
                              controller: _passwordSignInController,
                              type: TextInputType.visiblePassword,
                              validate: (value) {
                                // TODO
                              },
                              label: 'Password',
                              prefix: IconBroken.Lock,
                            ),
                          ),
                          const SizedBox(height : 100),
                          Container(
                            width: 350,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: primaryColor
                            ),
                            child: const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]
                      : [
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 350,
                            child: CustomTextField(
                              controller: _nameRegisterController,
                              type: TextInputType.text,
                              validate: (value) {
                                // TODO
                              },
                              label: 'Full Name',
                              prefix: IconBroken.Profile,
                            ),
                          ),
                          const SizedBox(height : 10),
                          SizedBox(
                            width: 350,
                            child: CustomTextField(
                              controller: _emailRegisterController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                // TODO
                              },
                              label: 'Email',
                              prefix: IconBroken.Message,
                            ),
                          ),
                          const SizedBox(height : 10),
                          SizedBox(
                            width: 350,
                            child: CustomTextField(
                              controller: _passwordRegisterController,
                              type: TextInputType.visiblePassword,
                              validate: (value) {
                                // TODO
                              },
                              label: 'Password',
                              prefix: IconBroken.Lock,
                            ),
                          ),
                          const SizedBox(height : 100),
                          Container(
                            width: 350,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: primaryColor
                            ),
                            child: const Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
