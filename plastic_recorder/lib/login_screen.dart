import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const bgcolor = Color.fromRGBO(246, 246, 248, 1);
const yellow = Color.fromRGBO(255, 159, 29, 1);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String email = '';
String password = '';


class _LoginScreenState extends State<LoginScreen> {
  
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future Login() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        print('login with $passwordController.text + $emailController.text');
        emailController.clear();
        passwordController.clear();
        Navigator.pushNamed(context, '/today');
      } on FirebaseAuthException catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message!),
        ));
      }
    } else {
      print('invalid username or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bgcolor,
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(height: 40),
                        Column(
                          children: [
                            Container(
                              width: deviceWidth * 0.7,
                              child: TextFormField(
                                autofocus: true,
                                controller: emailController,
                                validator: (email) {
                                  var emailReg = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                  if (email == null || email.isEmpty) {
                                    return 'Please enter a username';
                                    // !email.contains('@')
                                  } else if (!emailReg.hasMatch(email)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'email',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: deviceWidth * 0.7,
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                controller: passwordController,
                                obscureText: true,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter a password';
                                  } else if (val.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      //color black
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3)),
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            width: deviceWidth * 0.7,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: yellow,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onPressed: Login,
                                child: Text('Log in',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero, // Set this
                                padding: EdgeInsets.zero, // and this
                              ),
                              child: Text(
                                '  Sign up',
                                style: TextStyle(color: yellow),
                              ),
                            )
                          ],
                        )
                      ],
                    ))))));
  }
}
