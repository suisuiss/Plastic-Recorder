import 'package:flutter/material.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';

class Compare extends StatefulWidget {
  const Compare({Key? key}) : super(key: key);

  @override
  State<Compare> createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  @override
  Widget build(BuildContext context) {
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
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Positioned(
                            child: Image(
                              image: AssetImage('assets/bottle_fill.png'),
                              color: Colors.green,
                              width: 500,
                              height: 500,
                            ),
                          ),
                          Positioned(
                            child: Image(
                              image: AssetImage('assets/screen.png'),
                              width: 500,
                              height: 500,
                            ),
                            bottom: 140,
                          ),
                          Positioned(
                            child: Image(
                              image: AssetImage('assets/bottle.png'),
                              width: 500,
                              height: 500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                        " On April 1st, your plastic consumption is 521 points below average!"),
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
