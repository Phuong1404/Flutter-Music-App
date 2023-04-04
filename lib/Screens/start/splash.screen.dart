import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            body: SafeArea(
                child: Stack(children: [
              const GradientContainer(
                child: null,
                opacity: true,
              ),
              Container(
                  child: Center(
                      child: Image(
                image: AssetImage('assets/logo_app.png'),
                width: 150,
              ))),
            ]))));
  }
}
