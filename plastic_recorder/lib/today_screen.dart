import 'package:flutter/material.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:intl/intl.dart';

class Today extends StatelessWidget {
  Today({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    String formattedDate = DateFormat('MMMd').format(now);
    return Scaffold(
      body: Container(
        color: Color(0xffF6F6F8),
        child: Column(
          children: [
            header(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                color: Color(0xffF6F6F8),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.all(0),
                      child: Text(formattedDate,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            decoration: TextDecoration.none)  ),
                    ),
                    
                    Box(pieces: 2, points: 2),
                    Box(pieces: 3, points: 3),
                    Box(pieces: 5, points: 10),
                    Box(pieces: 1, points: 1),
                    Box(pieces: 10, points: 20),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Total: 36 point(s)',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Button(),
                  ],
                ),
              ),
            ),
            footer(),
          ],
        ),
      ),
    );
  }
}

class Box extends StatefulWidget {
  final int pieces;
  final int points;

  const Box({Key? key, required this.pieces, required this.points})
      : super(key: key);

  @override
  State<Box> createState() =>
      _BoxState(pieces: this.pieces, points: this.points);
}

class _BoxState extends State<Box> {
  int pieces;
  int points;

  _BoxState({required this.pieces, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(3.0),
      width: 450.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          top: BorderSide(width: 1.0, color: Color.fromARGB(255, 0, 0, 0)),
          left: BorderSide(width: 1.0, color: Color.fromARGB(255, 0, 0, 0)),
          right: BorderSide(width: 1.0, color: Color.fromARGB(255, 0, 0, 0)),
          bottom: BorderSide(
            width: 1.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'assets/water.png',
                scale: 0.2,
              )),
          Text(
            'Bottle',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.only(top: 5.5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Color(0xffFF9F1D)),
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFF9F1D),
                  ),
                  width: 125.0,
                  height: 28.0,
                  child: Text(
                    '$pieces piece(s)',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center,
                  )),
              Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.only(top: 3.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Color(0xffFF9F1D)),
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFF9F1D),
                  ),
                  width: 125.0,
                  height: 28.0,
                  child: Text(
                    '$points point(s)',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class Button extends StatefulWidget {
  const Button({Key? key}) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Compare Usage'),
        style: ElevatedButton.styleFrom(
          primary: Color(0xffFF9F1D),
        ),
        // ButtonStyle(
        //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //       RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(13.0),
        //           side: BorderSide(
        //             color: Color(0xffFF9F1D),
        //           )
        //       )
        //   ),
        // ),
      ),
    );
  }
}
