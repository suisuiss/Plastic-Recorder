import 'package:flutter/material.dart';

const bgcolor = Color(0xffF6F6F8);
const yellow = Color.fromRGBO(255, 159, 29, 1);
//use username email and password
String username = '';
String email = '';
String password = '';

final formKey = GlobalKey<FormState>();
final usernameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
bool isValid = formKey.currentState!.validate();

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bgcolor,
        body: Container(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Register',
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
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onChanged: (value) {
                      // username = value;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: deviceWidth * 0.7,
                  //email textform
                  child: TextFormField(
                    controller: emailController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onChanged: (value) {
                      // username = value;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: deviceWidth * 0.7,
                  
                  child: TextFormField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          //color black
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 3)),
                      labelText: 'Password',
                    ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                       if (isValid) {
                        username = usernameController.text;
                        password = passwordController.text;
                      } else {
                        print('invalid username or password');
                      }
                    },
                    child: Text('Register',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already a user?'),
                TextButton(
                  onPressed: () {
                    
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
        ))));
  }
}
