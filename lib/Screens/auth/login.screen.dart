import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

  static const routeName = '/login';
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GradientContainer(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: 0,
            ),
            extendBodyBehindAppBar: true,
            body: SafeArea(
                child: Stack(children: [
              const GradientContainer(
                child: null,
                opacity: true,
              ),
              SingleChildScrollView(
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 90),
                        child: Text("Hello, \nWelcome Back",
                            style: TextStyle(
                              height: 1,
                              fontSize: 37,
                              fontWeight: FontWeight.bold,
                              // color: Theme.of(context)
                              //     .colorScheme
                              //     .secondary,
                              color: Colors.white,
                            )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  width: 32,
                                  image: AssetImage('assets/google.png')),
                              SizedBox(width: 30),
                              Image(
                                  width: 32,
                                  image: AssetImage('assets/facebook.png'))
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 7,
                              left: 14,
                              right: 14,
                            ),
                            height: 57.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[900],
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  offset: Offset(0.0, 3.0),
                                )
                              ],
                            ),
                            child: TextField(
                              //controller: controller,
                              textAlignVertical: TextAlignVertical.center,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.name,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Color.fromARGB(255, 4, 192, 60),
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5,
                                    color: Colors.transparent,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: 'Email or Username',
                                // AppLocalizations.of(context)!
                                //     .enterName,
                                hintStyle: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              // onSubmitted: (String value) async {
                              //   if (value.trim() == '') {
                              //     await _addUserData(
                              //       AppLocalizations.of(context)!
                              //           .guest,
                              //     );
                              //   } else {
                              //     await _addUserData(value.trim());
                              //   }
                              //   Navigator.popAndPushNamed(
                              //     context,
                              //     '/pref',
                              //   );
                              // },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 7,
                              left: 14,
                              right: 14,
                            ),
                            height: 57.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[900],
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  offset: Offset(0.0, 3.0),
                                )
                              ],
                            ),
                            child: TextField(
                              //controller: controller,
                              obscureText: _isObscure,
                              textAlignVertical: TextAlignVertical.center,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.name,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Color.fromARGB(255, 4, 192, 60),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    padding: EdgeInsets.only(top: 2, left: 10),
                                    icon: Icon(_isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    color: Color.fromARGB(255, 208, 208, 208),
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    }),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5,
                                    color: Colors.transparent,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: 'Password',

                                // AppLocalizations.of(context)!
                                //     .enterName,
                                hintStyle: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              // onSubmitted: (String value) async {
                              //   if (value.trim() == '') {
                              //     await _addUserData(
                              //       AppLocalizations.of(context)!
                              //           .guest,
                              //     );
                              //   } else {
                              //     await _addUserData(value.trim());
                              //   }
                              //   Navigator.popAndPushNamed(
                              //     context,
                              //     '/pref',
                              //   );
                              // },
                            ),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 4),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.white70),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
                        onTap: () {
                              Navigator.popAndPushNamed(context, '/home');
                            },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          height: 55.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            // color: Theme.of(context)
                            //     .colorScheme
                            //     .secondary,
                            color: Color.fromARGB(255, 42, 215, 94),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5.0,
                                offset: Offset(0.0, 3.0),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              // AppLocalizations.of(context)!
                              //     .getStarted,
                              'Login',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, '/signin');
                            },
                            child: Center(
                              child: Text("Create account",
                                  style: TextStyle(color: Colors.white70)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]))));
  }
}
