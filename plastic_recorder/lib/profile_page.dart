import 'package:flutter/material.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:plastic_recorder/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _cpass = TextEditingController();
  bool isEditing = false;
  bool isLoading = false;
  var yellow = Color.fromRGBO(255, 159, 29, 1);
  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  Future _change() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance.currentUser!.updateEmail(_email.text);
        await FirebaseAuth.instance.currentUser!.updatePassword(_pass.text);

        setState(() {
          isEditing = false;
          isLoading = false;
        });
        _email.clear();
        _pass.clear();
        _cpass.clear();
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message!),
        ));
        setState(() {
          isEditing = false;
          isLoading = false;
        });

        _email.clear();
        _pass.clear();
        _cpass.clear();
      }
    } else {
      print('invalid email or password');
    }
  }

  Widget textformfield({@required hintText, required icon}) {
    final InputDecoration textFormStyle = InputDecoration(
      hintText: hintText,
      hintStyle:
          const TextStyle(letterSpacing: 1, fontSize: 20, color: Colors.black),
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 10)),
    );
    return Material(
      elevation: 2,
      child: TextFormField(
        enabled: false,
        textAlign: TextAlign.center,
        decoration: textFormStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final deviceHeight = MediaQuery.of(context).size.height;
    return isLoading
        ? Center(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(yellow),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.chevron_left_outlined,
                                      size: 45,
                                      color: Color(0xffFF9F1D),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !isEditing,
                                    child: IconButton(
                                        onPressed: () => {
                                              setState(() {
                                                isEditing = true;
                                              })
                                            },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 30,
                                        )),
                                  )
                                ]),
                          ]),
                    ),
                  ),
                  //BODY FORM
                  Expanded(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(
                            'assets/profileimg1.jpg',
                          ),
                          width: 150,
                          height: 150,
                        ),
                        Form(
                          key: formKey,
                          child: Container(
                            height: deviceHeight * 0.4,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                isEditing
                                    ? TextFormField(
                                        controller: _email,
                                        textAlign: TextAlign.center,
                                        validator: (email) {
                                          if (email == null || email.isEmpty) {
                                            return 'Please enter an email';
                                          } else if (!email.contains('@')) {
                                            return 'Please enter a valid email';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Enter your new email',
                                            hintStyle: const TextStyle(
                                                letterSpacing: 1,
                                                fontSize: 20,
                                                color: Colors.grey),
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: Colors.black,
                                            )))
                                    : textformfield(
                                        hintText: '${user.email}',
                                        icon: Icons.email,
                                      ),
                                isEditing
                                    ? TextFormField(
                                        controller: _pass,
                                        textAlign: TextAlign.center,
                                        obscureText: true,
                                        validator: (password) {
                                          if (password == null) {
                                            return 'Please enter a password';
                                          } else if (password.length < 6) {
                                            return 'Password must be at least 6 characters';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'New password',
                                            hintStyle: const TextStyle(
                                                letterSpacing: 1,
                                                fontSize: 20,
                                                color: Colors.grey),
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: Colors.black,
                                            )))
                                    : textformfield(
                                        hintText: 'Password',
                                        icon: Icons.lock,
                                      ),
                                Visibility(
                                  visible: isEditing,
                                  child: TextFormField(
                                      controller: _cpass,
                                      textAlign: TextAlign.center,
                                      obscureText: true,
                                      validator: (val) {
                                        if (val == null) {
                                          return 'Please confirm your password';
                                        } else if (val != _pass.text) {
                                          return 'Password does not match';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Confirm the password',
                                          hintStyle: const TextStyle(
                                              letterSpacing: 1,
                                              fontSize: 20,
                                              color: Colors.grey),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.black,
                                          ))),
                                ),
                                Container(
                                  height: 40,
                                  width: 160,
                                  child: isEditing
                                      ? ElevatedButton(
                                          onPressed: _change,
                                          style: ElevatedButton.styleFrom(
                                              primary: const Color.fromARGB(
                                                  221, 252, 157, 15)),
                                          child: const Center(
                                            child: Text(
                                              "update",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : ElevatedButton(
                                          onPressed: _signOut,
                                          style: ElevatedButton.styleFrom(
                                              primary: const Color.fromARGB(
                                                  221, 252, 157, 15)),
                                          child: const Center(
                                            child: Text(
                                              "log out",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  footer()
                ],
              ),
            ),
          );
  }
}
