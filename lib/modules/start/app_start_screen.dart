// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:marcelina/shared/components/constants.dart';
// import '../login/login_screen.dart';
//
//
// class StartScreen extends StatelessWidget {
//   const StartScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor:backgroundColor,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/logo.jpg',
//               height: 270,
//               width: 270,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ShaderMask(
//               shaderCallback: (bounds) => LinearGradient(
//                 colors: [secondaryColor, primaryColor],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ).createShader(bounds
//               ),
//               child: Text(
//                 'Marcelina',
//                 style: GoogleFonts.abhayaLibre(
//                     fontSize: 50,
//                     color: Colors.white
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 70,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: secondaryColor,
//               ),
//               width: 200,
//               child: MaterialButton(
//                 onPressed: (){
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => const LoginScreen()),
//                       (value) => false
//                   );
//                 },
//                 child: Text(
//                   'Get Started',
//                   style: GoogleFonts.abhayaLibre(
//                       fontSize: 30,
//                       color: primaryColor2
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
