import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcelina/layouts/app_layout_screen.dart';
import 'package:marcelina/layouts/cubit/cubit.dart';
import 'package:marcelina/modules/login/cubit/cubit.dart';
import 'package:marcelina/modules/login/cubit/states.dart';
import 'package:marcelina/shared/components/components.dart';
import 'package:marcelina/shared/components/constants.dart';
import 'package:marcelina/shared/network/local/cache_helper.dart';
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordRegisterController.text) {
      return 'Passwords do not match';
    }
    return null;
  }




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if(state is LoginSuccessState){
            CacheHelper.putData(
                key: 'uId',
                data: state.uId
            ).then((value){
              uId = state.uId;
              Navigator.pushAndRemoveUntil(
                  context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => AppCubit()..getUserData(),
                    child: LayoutScreen(),
                  ),
                ),
                    (route) => false,
              );
            });

          }else if(state is LoginErrorState){

            showToast(text: getFirebaseAuthErrorMessage(state.error), state: ToastStates.ERROR);

          }else if(state is CreateUserSuccessState){

            CacheHelper.putData(
                key: 'uId',
                data: state.uId
            ).then((value){
              uId = state.uId;
              Navigator.pushAndRemoveUntil(
                  context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => AppCubit()..getUserData(),
                    child: LayoutScreen(),
                  ),
                ),
                    (route) => false,
              );
            });

          }else if(state is RegisterErrorState){

            showToast(text: getFirebaseAuthErrorMessage(state.error), state: ToastStates.ERROR);
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
                                              validate: validateEmail,
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
                                                )
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
                                              validate: validateName,
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
                                              validate: validateEmail,
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
                                              validate: validatePhoneNo,
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
                                              validate: validatePassword,
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