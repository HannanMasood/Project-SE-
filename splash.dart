import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetoLogin();
  }

  _navigatetoLogin() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue.shade700,
          Colors.pink.shade700,
          Colors.yellow.shade700,
        ],
      )),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 40,
              color: Colors.white,
            ),
            Text(
              'taskphile',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
            ),
          ],
        ),
      ),
    )));
  }
}
