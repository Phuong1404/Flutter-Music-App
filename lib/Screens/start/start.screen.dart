import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
  static const routeName = '/startlogin';
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
            body: SafeArea(
                child: Stack(children: [
              const GradientContainer(
                child: null,
                opacity: true,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Column(
                              children: [
                                Center(
                                  child: Container(
                                    child: Image(
                                        width: 70,
                                        image: AssetImage(
                                            'assets/logo_app_white.png')),
                                  ),
                                ),
                                SizedBox(
                                  height: 90,
                                ),
                                Text(
                                  "Million of songs.\n Free on spotify.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                      height: 0.97),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  // onTap: () async {
                                  //   if (controller.text.trim() == '') {
                                  //     await _addUserData('Guest');
                                  //   } else {
                                  //     await _addUserData(
                                  //       controller.text.trim(),
                                  //     );
                                  //   }
                                  //   Navigator.popAndPushNamed(
                                  //       context, '/pref');
                                  // },
                                  child: Container(
                                    // margin: const EdgeInsets.symmetric(
                                    //   vertical: 10.0,
                                    // ),
                                    height: 53.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      // color: Theme.of(context)
                                      //     .colorScheme
                                      //     .secondary,
                                      color: Color.fromARGB(255, 30, 215, 96),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5.0,
                                          offset: Offset(0.0, 3.0),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.popAndPushNamed(
                                              context, '/signin');
                                        },
                                        child: Text(
                                          // AppLocalizations.of(context)!
                                          //     .getStarted,
                                          'Free Signup Now',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  // onTap: () async {
                                  //   if (controller.text.trim() == '') {
                                  //     await _addUserData('Guest');
                                  //   } else {
                                  //     await _addUserData(
                                  //       controller.text.trim(),
                                  //     );
                                  //   }
                                  //   Navigator.popAndPushNamed(
                                  //       context, '/pref');
                                  // },
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      height: 53.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          // color: Theme.of(context)
                                          //     .colorScheme
                                          //     .secondary,
                                          color: Colors.transparent,
                                          border: Border(
                                            top: BorderSide(color: Colors.grey),
                                            left:
                                                BorderSide(color: Colors.grey),
                                            right:
                                                BorderSide(color: Colors.grey),
                                            bottom:
                                                BorderSide(color: Colors.grey),
                                          )),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Image(
                                                width: 22,
                                                image: AssetImage(
                                                    'assets/google.png')),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 58),
                                            child: Center(
                                              child: Text(
                                                // AppLocalizations.of(context)!
                                                //     .getStarted,
                                                'Continue with Google',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                GestureDetector(
                                  // onTap: () async {
                                  //   if (controller.text.trim() == '') {
                                  //     await _addUserData('Guest');
                                  //   } else {
                                  //     await _addUserData(
                                  //       controller.text.trim(),
                                  //     );
                                  //   }
                                  //   Navigator.popAndPushNamed(
                                  //       context, '/pref');
                                  // },
                                  child: Container(
                                      // margin: const EdgeInsets.symmetric(
                                      //   vertical: 10.0,
                                      // ),
                                      height: 53.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          // color: Theme.of(context)
                                          //     .colorScheme
                                          //     .secondary,
                                          color: Colors.transparent,
                                          border: Border(
                                            top: BorderSide(color: Colors.grey),
                                            left:
                                                BorderSide(color: Colors.grey),
                                            right:
                                                BorderSide(color: Colors.grey),
                                            bottom:
                                                BorderSide(color: Colors.grey),
                                          )),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Image(
                                                width: 23,
                                                image: AssetImage(
                                                    'assets/facebook_circle.png')),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 48),
                                            child: Center(
                                              child: Text(
                                                // AppLocalizations.of(context)!
                                                //     .getStarted,
                                                'Continue with Facebook',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: GestureDetector(
                                    child: Text("Login now",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // color: Theme.of(context)
                                            //     .colorScheme
                                            //     .secondary,
                                            color: Colors.white,
                                            fontSize: 16)),
                                    onTap: () {
                                      Navigator.popAndPushNamed(
                                          context, '/login');
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]))));
  }
}
