import 'package:flutter/material.dart';
import 'package:plastic_recorder/editprofile_page.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget textfield({@required hintText, required icon}) {
    return Material(
      elevation: 2,
      shadowColor: const Color.fromARGB(255, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        enabled: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Color.fromARGB(137, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: Icon(icon),
            iconColor: const Color.fromARGB(77, 0, 0, 0),
            fillColor: const Color.fromARGB(77, 255, 255, 255),
            filled: true,
            border: const UnderlineInputBorder()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          textfield(hintText: 'Email', icon: Icons.email),
                          textfield(hintText: 'Password', icon: Icons.lock),
                          Container(
                            height: 40,
                            width: 160,
                            child: ElevatedButton(
                              onPressed: () {},
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
