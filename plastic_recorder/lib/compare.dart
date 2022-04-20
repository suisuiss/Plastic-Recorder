import 'package:flutter/material.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:intl/intl.dart';

class Compare extends StatefulWidget {
  const Compare({Key? key}) : super(key: key);

  @override
  State<Compare> createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  @override
  Widget build(BuildContext context) {
    // Full screen width and height
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Height (without SafeArea)
    var padding = MediaQuery.of(context).viewPadding;
    double height1 = height - padding.top - padding.bottom;

    // Height (without status bar)
    double height2 = height - padding.top;

    // Height (without status and toolbar)
    double height3 = height - padding.top - kToolbarHeight;

    var now = new DateTime.now();
    String formattedDate = DateFormat('MMMd').format(now);

    int points = 521;

    return Scaffold(
      //You should use `Scaffold` if you have `TextField` in body.
      //Otherwise on focus your `TextField` won`t scroll when keyboard popup.
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Header Container
            Container(
              alignment: Alignment.center,
              child: header(),
            ),

            //Body Container
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: 400,
                      //color: Colors.red,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            Container(
                              child: FittedBox(
                                child: Image.asset(
                                  'assets/bottle_fill.png',
                                  color: Colors.green,
                                ),
                                fit: BoxFit.fill,
                              ),
                              height: 70,
                              width: 200,
                            ),
                            Container(
                              child: Image.asset('assets/bottle.png'),
                            ),
                            Container(
                              child: Image.asset('assets/divider.png'),
                              width: 130,
                              height: 100,
                            ),
                          ]),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'On ' +
                                  formattedDate +
                                  ', your plastic consumption is ',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  decoration: TextDecoration.none),
                              children: <TextSpan>[
                                TextSpan(
                                    text: points.toString(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF9F1D),
                                        decoration: TextDecoration.none)),
                                TextSpan(
                                  text: ' points below average!',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),

            //Footer Container
            //Here you will get unexpected behaviour when keyboard pops-up.
            //So its better to use `bottomNavigationBar` to avoid this.
            Container(
              alignment: Alignment.center,
              child: footer(),
            ),
          ],
        ),
      ),
    );
  }
}
