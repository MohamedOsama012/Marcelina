import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marcelina/layouts/app_layout_screen.dart';
import 'package:marcelina/layouts/cubit/cubit.dart';
import 'package:marcelina/modules/login/login_screen.dart';
import 'package:marcelina/shared/MyBlocObserver.dart';
import 'package:marcelina/shared/components/constants.dart';
import 'package:marcelina/shared/network/local/cache_helper.dart';
import 'package:marcelina/shared/styles/color.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  uId = CacheHelper.getData(key: 'uId');
  Widget startWidget;

  if(uId == null){
    startWidget = LoginScreen();
  }else{
    startWidget = LayoutScreen();
  }

  runApp(MyApp(startWidget: startWidget,));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;

   MyApp({this.startWidget,super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (BuildContext context) {
            return AppCubit()..getUserData();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: startWidget,
      ),
    );
  }
}
