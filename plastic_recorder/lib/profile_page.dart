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
final user = FirebaseAuth.instance.currentUser!;
class _ProfilePageState extends State<ProfilePage> {
  var email = user.email;
  Widget textformfield({@required hintText, required icon}) {
    return Material(
      elevation: 2,
      shadowColor: Colors.black,
      child: TextFormField(
        enabled: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            fillColor: const Color.fromARGB(77, 255, 255, 255),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            )),
      ),
    );
  }

  @override
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(BuildContext context) {
    var email = user.email;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            hd(context),
            Expanded(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 330,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(user.email!,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          textfield(
                              hintText: '$email',
                              icon: Icons.account_circle_outlined),
                          textfield(hintText: 'Email', icon: Icons.email),
                          textfield(
                              hintText: 'change the password',
                              icon: Icons.lock),
                          Container(
                            height: 40,
                            width: 160,
                            child: ElevatedButton(
                              onPressed: ()=>{
                                 FirebaseAuth.instance.signOut(),
                                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) =>false)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(221, 252, 157, 15)),
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
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: const DecorationImage(
                          alignment: Alignment.center,
                          image: AssetImage('assets/profileimg.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
            footer()
          ],
        ),
      ),
    );
  }
}

Widget hd(BuildContext context) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.chevron_left_outlined,
            size: 45,
            color: Color(0xffFF9F1D),
          ),
          IconButton(
              onPressed: (() => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()))),
              icon: Icon(
                Icons.edit,
                size: 30,
              ))
        ]),
      ]),
    ),
  );
}
