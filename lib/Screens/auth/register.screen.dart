import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/API/AuthAPI.api.dart';
import 'package:music_app/Services/store_token.service.dart';
import 'package:music_app/Widgets/loadding.widget.dart';
import 'package:provider/provider.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';

class RegisterScreen extends StatefulWidget {
  final String email;
  const RegisterScreen({super.key, required this.email});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();

  static const routeName = '/register';
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = true;
  bool _isObscure1 = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                          SizedBox(
                            height: 55,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Center(
                              child: Text("Sign In",
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    // color: Theme.of(context)
                                    //     .colorScheme
                                    //     .secondary,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Column(
                            children: [
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
                                  controller: nameController,
                                  textAlignVertical: TextAlignVertical.center,
                                  cursorColor: Color.fromARGB(255, 4, 192, 60),
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Full Name',
                                    // AppLocalizations.of(context)!
                                    //     .enterName,
                                    hintStyle: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
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
                                  controller: usernameController,
                                  textAlignVertical: TextAlignVertical.center,
                                  textCapitalization:
                                      TextCapitalization.sentences,
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
                                    // AppLocalizations.of(context)!
                                    //     .enterName,
                                    hintStyle: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
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
                                  controller: passwordController,
                                  obscureText: _isObscure,
                                  textAlignVertical: TextAlignVertical.center,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(color: Colors.white),
                                  cursorColor: Color.fromARGB(255, 4, 192, 60),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        padding:
                                            EdgeInsets.only(top: 2, left: 10),
                                        icon: Icon(_isObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        color:
                                            Color.fromARGB(255, 208, 208, 208),
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
                                ),
                              ),
                              SizedBox(
                                height: 15,
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
                                  controller: repasswordController,
                                  obscureText: _isObscure1,
                                  textAlignVertical: TextAlignVertical.center,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(color: Colors.white),
                                  cursorColor: Color.fromARGB(255, 4, 192, 60),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        padding:
                                            EdgeInsets.only(top: 2, left: 10),
                                        icon: Icon(_isObscure1
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        color:
                                            Color.fromARGB(255, 208, 208, 208),
                                        splashColor: Colors.transparent,
                                        onPressed: () {
                                          setState(() {
                                            _isObscure1 = !_isObscure1;
                                          });
                                        }),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Re Password',

                                    // AppLocalizations.of(context)!
                                    //     .enterName,
                                    hintStyle: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final name = nameController.text;
                                  final username = usernameController.text;
                                  final password = passwordController.text;
                                  final repassword = repasswordController.text;
                                  if (name.isNotEmpty &&
                                      username.isNotEmpty &&
                                      password.isNotEmpty &&
                                      repassword.isNotEmpty) {
                                    if (repassword == password) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          context = context;
                                          return const Loading();
                                        },
                                      );
                                      final data = await AuthApi().Signup(name,
                                          widget.email, username, password);
                                      if (data['status_code'] != 400) {
                                        final login = await AuthApi()
                                            .Login(username, password);
                                        await StoreToken.storageToken(
                                            login['data']['id']);
                                        Navigator.pop(context);
                                        Navigator.popAndPushNamed(
                                            context, '/home');
                                      }
                                    }
                                  }

                                  // Future.delayed(
                                  //     const Duration(milliseconds: 2000), () {

                                  // });
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
                                      'Sign In',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text("Or continue with",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // color: Theme.of(context)
                                      //     .colorScheme
                                      //     .secondary,
                                      color: Colors.white70.withOpacity(0.7),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
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
                                            color:
                                                Colors.white70.withOpacity(0.7),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
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
                          )
                        ],
                      )))
            ]))));
  }
}
