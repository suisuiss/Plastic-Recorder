import 'package:flutter/material.dart';
import 'package:plastic_recorder/editprofile_page.dart';
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

User? usr = FirebaseAuth.instance.currentUser;
var uemail = usr?.email;
var uid = usr?.uid;
getCurrentUser() async {
  final User us = await auth.currentUser!;
  final uid = us.uid;
  print(uid);
}

class _ProfilePageState extends State<ProfilePage> {
  var isEdit = false;
  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
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
        textAlign: TextAlign.center,
        decoration: textFormStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final formKey = GlobalKey<FormState>();
    final deviceHeight = MediaQuery.of(context).size.height;
    bool isEdit = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Column(
            children: [
              hd(context, isEdit),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/profileimg.jpg',
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
                              isEdit
                                  ? Text('sdasd')
                                  : textformfield(
                                      // hintText: '$GetUserData() ',
                                      hintText: '${user.email}',

                                      icon: Icons.email,
                                    ),
                              textformfield(
                                hintText: 'Password',
                                icon: Icons.lock,
                              ),
                              Container(
                                height: 40,
                                width: 160,
                                child: ElevatedButton(
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
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       alignment: AlignmentDirectional.topStart,
                //       width: 120,
                //       height: 120,
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.white, width: 5),
                //         shape: BoxShape.circle,
                //         color: Colors.white,
                //         image: const DecorationImage(
                //           alignment: Alignment.center,
                //           image: AssetImage('assets/profileimg.jpg'),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
              footer()
            ],
          ),
        ),
      ),
    );
  }

  Widget hd(BuildContext context, bool isEdit) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
            IconButton(
                onPressed: () => {
                      setState(() {
                        isEdit = true;
                      })
                    },
                icon: Icon(
                  Icons.edit,
                  size: 30,
                ))
          ]),
        ]),
      ),
    );
  }
}
