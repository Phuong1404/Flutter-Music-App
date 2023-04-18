import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/API/AuthAPI.api.dart';
import 'package:music_app/Services/store_token.service.dart';
import 'package:music_app/Widgets/alert_notification.widget.dart';
import 'package:provider/provider.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

  static const routeName = '/login';
}

class _LoginScreenState extends State<LoginScreen> {
  //Khai báo các controller
  bool _isObscure = true;
  bool _validateUsername = false;
  bool _validatePassword = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                              controller: usernameController,
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
                                hintText: 'Username',
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                  // fontSize: _validateUsername ? 13.5 : null
                                ),
                              ),
                              // onChanged: (text) => {
                              //   if (_validateUsername == true)
                              //     {
                              //       setState(() {
                              //         _validateUsername = false;
                              //       })
                              //     }
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
                              controller: passwordController,
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
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                  // fontSize: _validatePassword ? 13.5 : null
                                ),
                              ),
                              // onChanged: (text) => {
                              //   if (_validatePassword == true)
                              //     {
                              //       setState(() {
                              //         _validatePassword = false;
                              //       })
                              //     }
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
                        onTap: () async {
                          final username = usernameController.text;
                          final password = passwordController.text;
                          if (username.isNotEmpty && password.isNotEmpty) {
                            username.replaceAll(" ", "");
                            password.replaceAll(" ", "");
                            final data =
                                await AuthApi().Login(username, password);
                            if (data['status_code'] == 400) {
                              AlertNotification err_alert =
                                  new AlertNotification(
                                title: 'Error',
                                message: data['error'],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return err_alert;
                                },
                              );
                            }
                            else{
                              int Id=data['data']['id'];
                              await StoreToken.storageToken(Id.toString());
                              Navigator.popAndPushNamed(context, '/home');
                            }
                          } else {
                            AlertNotification err_alert = new AlertNotification(
                              title: 'Error',
                              message: 'Username and Password didn\'t empty',
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return err_alert;
                              },
                            );
                          }
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
                      SizedBox(
                        height: 10,
                      ),
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
