import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcelina/modules/login/login_screen.dart';
import 'package:marcelina/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'uId');
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (value) => false
  );
}


String? uId;