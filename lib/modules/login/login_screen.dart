import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcelina/layouts/app_layout_screen.dart';
import 'package:marcelina/modules/login/cubit/cubit.dart';
import 'package:marcelina/modules/login/cubit/states.dart';
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
  final _phoneRegisterController = TextEditingController();
  final _passwordRegisterController = TextEditingController();
  final _confirmPasswordRegisterController = TextEditingController();
  final _nameRegisterController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    value = value.trim();
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  String? _validatePhoneNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    final cleanedPhoneNo = value.replaceAll(RegExp(r'[^0-9]'), '');

    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(cleanedPhoneNo)) {
      return 'Phone number can only contain digits';
    }

    if (cleanedPhoneNo.length < 6) {
      return 'Phone number is too short';
    }

    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordRegisterController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String _getFirebaseAuthErrorMessage(String errorCode) {
    if (errorCode.contains('invalid-email')) {
      return 'Invalid email format. Please enter a valid email.';
    } else if (errorCode.contains('user-not-found')) {
      return 'No user found with this email. Please sign up first.';
    } else if (errorCode.contains('wrong-password')) {
      return 'Incorrect password. Please try again.';
    } else if (errorCode.contains('email-already-in-use')) {
      return 'This email is already registered. Try logging in.';
    } else if (errorCode.contains('weak-password')) {
      return 'Your password is too weak. Try a stronger one.';
    } else if (errorCode.contains('operation-not-allowed')) {
      return 'Email sign-in is disabled. Contact support.';
    } else if (errorCode.contains('too-many-requests')) {
      return 'Too many failed attempts. Try again later.';
    } else if (errorCode.contains('network-request-failed')) {
      return 'Network error. Please check your internet connection.';
    } else if (errorCode.contains('invalid-credential')) {
      return 'Email or password is incorrect. Please try again.';
    } else if (errorCode.contains('user-disabled')) {
      return 'This account has been disabled. Contact support.';
    } else {
      return 'An unknown error occurred. Please try again.';
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if(state is LoginSuccessState){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LayoutScreen()),
                (value) => false
            );
          }else if(state is LoginErrorState){

            showToast(text: _getFirebaseAuthErrorMessage(state.error), state: ToastStates.ERROR);
          }else if(state is RegisterSuccessState){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LayoutScreen()),
                    (value) => false
            );
          }else if(state is RegisterErrorState){

            showToast(text: _getFirebaseAuthErrorMessage(state.error), state: ToastStates.ERROR);
          }
        },
        builder: (BuildContext context, LoginStates state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bk5.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 350,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.fastOutSlowIn,
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
                                            _isSignInSelected = true;
                                          });
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: SizedBox.expand(
                                          child: Center(
                                            child: Text(
                                              "Sign in",
                                              style: TextStyle(
                                                color: _isSignInSelected
                                                    ? Colors.white
                                                    : primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: _isSignInSelected ? 20 : 14
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
                                            _isSignInSelected = false;
                                          });
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: SizedBox.expand(
                                          child: Center(
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                color: _isSignInSelected
                                                    ? primaryColor
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: _isSignInSelected ? 14 : 20
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
                          const SizedBox(height: 35),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                ConditionalBuilder(
                                    condition: _isSignInSelected,
                                    builder: (context) => Form(
                                      key: _signInFormKey,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 350,
                                            child: CustomTextField(
                                              controller: _emailSignInController,
                                              type: TextInputType.emailAddress,
                                              validate: _validateEmail,
                                              label: 'Email',
                                              prefix: IconBroken.Message,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 350,
                                            child: CustomTextField(
                                              controller: _passwordSignInController,
                                              type: TextInputType.visiblePassword,
                                              suffix: cubit.suffix,
                                              isPassword: cubit.isPassword,
                                              suffixPressed: (){
                                                cubit.changePasswordVisibility();
                                              },
                                              validate: (value){
                                                if(value!.isEmpty){
                                                   return 'Please enter your password';
                                                }
                                                return null;
                                              },
                                              label: 'Password',
                                              prefix: IconBroken.Lock,
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                          Material(
                                            elevation: 10,
                                            borderRadius: BorderRadius.circular(35),
                                            child: Container(
                                              width: 200,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(35),
                                                color: primaryColor,
                                              ),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  if (_signInFormKey.currentState!.validate()) {
                                                    cubit.userLogin(_emailSignInController.text, _passwordSignInController.text);
                                                  }
                                                },
                                                child: const Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    fallback: (context) => Form(
                                      key: _registerFormKey,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 350,
                                            child: CustomTextField(
                                              controller: _nameRegisterController,
                                              type: TextInputType.name,
                                              validate: _validateName,
                                              label: 'Name',
                                              prefix: IconBroken.Profile,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 350,
                                            child: CustomTextField(
                                              controller: _emailRegisterController,
                                              type: TextInputType.emailAddress,
                                              validate: _validateEmail,
                                              label: 'Email',
                                              prefix: IconBroken.Message,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 350,
                                            child: CustomTextField(
                                              controller: _phoneRegisterController,
                                              type: TextInputType.phone,
                                              validate: _validatePhoneNo,
                                              label: 'Phone',
                                              prefix: IconBroken.Call,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 350,
                                            child: CustomTextField(
                                              controller: _passwordRegisterController,
                                              type: TextInputType.visiblePassword,
                                              suffix: cubit.suffix,
                                              suffixPressed: (){
                                                cubit.changePasswordVisibility();
                                              },
                                              isPassword: cubit.isPassword,
                                              validate: _validatePassword,
                                              label: 'Password',
                                              prefix: IconBroken.Lock,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 350,
                                            child: CustomTextField(
                                              controller: _confirmPasswordRegisterController,
                                              type: TextInputType.visiblePassword,
                                              suffix: cubit.suffix,
                                              isPassword: cubit.isPassword,
                                              suffixPressed: (){
                                                cubit.changePasswordVisibility();
                                              },
                                              validate: _validateConfirmPassword,
                                              label: 'Confirm Password',
                                              prefix: IconBroken.Lock,
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                          Material(
                                            elevation: 10,
                                            borderRadius: BorderRadius.circular(35),
                                            child: Container(
                                                width: 200,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(35),
                                                  color: primaryColor,
                                                ),
                                                child: MaterialButton(
                                                  onPressed: (){
                                                    if(_registerFormKey.currentState!.validate()){
                                                      cubit.userRegister(
                                                        _nameRegisterController.text,
                                                        _emailRegisterController.text,
                                                        _phoneRegisterController.text,
                                                        _passwordRegisterController.text
                                                      );
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Register',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}