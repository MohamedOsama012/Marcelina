import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcelina/modules/login/login_screen.dart';
import 'package:marcelina/shared/network/local/cache_helper.dart';


String? validateEmail(String? value) {
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

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');
  if (!passwordRegex.hasMatch(value)) {
    return 'Use both letters & numbers.';
  }
  return null;
}

String? validatePhoneNo(String? value) {
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

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  }
  return null;
}


String getFirebaseAuthErrorMessage(String errorCode) {
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

void signOut(context) {
  CacheHelper.removeData(key: 'uId');
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (value) => false
  );
}


String? uId;