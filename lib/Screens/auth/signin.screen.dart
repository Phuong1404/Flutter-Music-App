import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

import 'package:music_app/Widgets/gradient_container.widget.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
  static const routeName = '/signin';
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            body: SafeArea(
              child: Stack(
                children: [
                  const GradientContainer(
                    child: null,
                    opacity: true,
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            //physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Spotify\nClone\n',
                                        style: TextStyle(
                                          height: 0.97,
                                          fontSize: 75,
                                          fontWeight: FontWeight.bold,
                                          // color: Theme.of(context)
                                          //     .colorScheme
                                          //     .secondary,
                                          color:
                                              Color.fromARGB(255, 42, 215, 94),
                                        ),
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Music',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 75,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 80,
                                              // color: Theme.of(context)
                                              //     .colorScheme
                                              //     .secondary,
                                              color: Color.fromRGBO(
                                                  42, 215, 94, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                        bottom: 7,
                                        left: 10,
                                        right: 10,
                                      ),
                                      height: 57.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                        cursorColor:
                                            Color.fromARGB(255, 4, 192, 60),
                                        style: TextStyle(color: Colors.white),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1.5,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          prefixIcon: IconButton(
                                            padding: EdgeInsets.only(top: 2),
                                            onPressed: () {},
                                            icon: Icon(Icons.person),
                                            // color: Theme.of(context)
                                            //     .colorScheme
                                            //     .secondary,
                                            color: Color.fromARGB(
                                                255, 42, 215, 94),
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Enter Your Email',
                                          // AppLocalizations.of(context)!
                                          //     .enterName,
                                          hintStyle: const TextStyle(
                                            color: Colors.white60,
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
                                    GestureDetector(
                                      onTap: () async {
                                        // if (controller.text.trim() == '') {
                                        //   await _addUserData('Guest');
                                        // } else {
                                        //   await _addUserData(
                                        //     controller.text.trim(),
                                        //   );
                                        // }
                                        Navigator.popAndPushNamed(
                                            context, '/register');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 10.0,
                                        ),
                                        height: 55.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          // color: Theme.of(context)
                                          //     .colorScheme
                                          //     .secondary,
                                          color:
                                              Color.fromARGB(255, 42, 215, 94),
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
                                            'Get Started',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                // AppLocalizations.of(context)!
                                                //     .disclaimerText,
                                                'already have an account ?  ',
                                                style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.popAndPushNamed(
                                                      context, '/login');
                                                },
                                                child: Text(
                                                  'Login here!',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          42, 215, 94, 1)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
