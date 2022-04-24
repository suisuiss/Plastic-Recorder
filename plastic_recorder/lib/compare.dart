import 'package:flutter/material.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:intl/intl.dart';
import 'package:flutter/animation.dart';

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

    int avg = 2500;
    int points = 300;
    double progress = points / avg;

    String display = ' points below average!';
    if (progress > 1) {
      display = ' points above average!';
    }

    var color = ColorTween(begin: Colors.green, end: Colors.red);

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
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Container(
                        width: width,
                        height: 400,
                        //color: Colors.red,
                        child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              Positioned(
                                child: Container(
                                  child: FittedBox(
                                    child: Image.asset(
                                      'assets/bottle_fill.png',
                                      color: color.lerp(progress),
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  height: 278 * progress.clamp(0, 1), //278 Max
                                  width: 200,
                                ),
                                bottom: 36,
                              ),
                              Positioned(
                                child: Container(
                                  child: FittedBox(
                                    child: Image.asset(
                                      'assets/bottle.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  height: 350,
                                  width: 350,
                                ),
                                bottom: 36,
                              ),
                              Positioned(
                                child: Container(
                                  child: Image.asset('assets/divider.png'),
                                  width: 130,
                                  height: 50,
                                ),
                                bottom:
                                    8 + (282 * progress.clamp(0, 1)), //Max 290
                              ),
                              Positioned(
                                child: Container(
                                  child: DefaultTextStyle(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.none),
                                    child: Text(
                                      points.toString(),
                                    ),
                                  ),
                                  width: 130,
                                  height: 32,
                                ),
                                bottom:
                                    8 + (282 * progress.clamp(0, 1)), //Max 290
                              ),
                            ]),
                      ),
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
                                decoration: TextDecoration.none,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (avg - points).abs().toString(),
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFF9F1D),
                                      decoration: TextDecoration.none),
                                ),
                                TextSpan(
                                  text: display,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  ),
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
