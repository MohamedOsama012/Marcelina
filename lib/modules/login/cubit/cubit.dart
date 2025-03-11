import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcelina/models/user_model.dart';
import 'package:marcelina/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibility());
  }

  late UserModel userModel;
  
  void userLogin(String email, String password){
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((e){
      emit(LoginErrorState(e.toString()));
    });
  }

  void userRegister(String name, String email,String phone, String password){
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email, password: password
    ).then((value){
      userCreate(
          name,
          email,
          phone,
          value.user!.uid
      );
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((e){
      emit(RegisterErrorState(e.toString()));
    });
  }

  void userCreate(String name, String email, String phone, String uId){
    UserModel model = UserModel(name: name, email: email, phone: phone, uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value){
          emit(CreateUserSuccessState(uId));
        }).catchError((e){
          emit(CreateUserSuccessState(e.toString()));
        });
  }



}