import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const bgcolor = Color(0xffF6F6F8);
const yellow = Color.fromRGBO(255, 159, 29, 1);
//use username email and password
String email = '';
String password = '';
String cpassword = '';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  Future signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(), password: passwordController.text.trim());
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message!),
           
        ));
      }
    } else {
      print('invalid email or password');
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
                      'Sign up',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 40),
                    Column(
                      children: [
                        Container(
                          width: deviceWidth * 0.7,
                          //username text
                          child: TextFormField(
                            autofocus: true,
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'email',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return 'Please enter a username';
                              } else if (!email.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: deviceWidth * 0.7,
                          //email textform
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: 'password',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            obscureText: true,
                            validator: (password) {
                              if (password == null) {
                                return 'Please enter a password';
                              } else if (password.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: deviceWidth * 0.7,
                          child: TextFormField(
                            controller: cpasswordController,
                            style: TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  //color black
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 3)),
                              labelText: 'Comfirm Password',
                            ),
                            validator: (val) {
                              if (val == null) {
                                return 'Please confirm your password';
                              } else if (val != passwordController.text) {
                                return 'Password does not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                        width: deviceWidth * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: yellow,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: signUp,
                            child: Text('Sign up',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20)),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already a user?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero, // Set this
                            padding: EdgeInsets.zero, // and this
                          ),
                          child: Text(
                            '  Log in',
                            style: TextStyle(color: yellow),
                          ),
                        )
                      ],
                    )
                  ],
                ))),
          ),
        ));
  }
}
