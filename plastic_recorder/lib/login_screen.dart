import 'package:flutter/material.dart';

const bgcolor = Color.fromRGBO(246, 246, 248, 1);
const yellow = Color.fromRGBO(255, 159, 29, 1);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final formKey = GlobalKey<FormState>();
final usernameController = TextEditingController();
final passwordController = TextEditingController();
bool isValid = formKey.currentState!.validate();
String username = '';
String password = '';
 

class _LoginScreenState extends State<LoginScreen> {
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
                    controller: usernameController,
                    validator: (username){
                      if(username==null){
                        return 'Please enter a username';
                      }
                      return null;
                      
                    },
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: deviceWidth * 0.7,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value==null) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
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
                    }
                     ,
                    child: Text('Log in',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/calender');
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
        ))));
  }
}
