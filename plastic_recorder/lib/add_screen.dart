import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:intl/intl.dart';

class Add extends StatelessWidget {
  Add({Key? key}) : super(key: key);

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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Text("Add Plastics",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  decoration: TextDecoration.none)),
                        ),
                        Box(
                          pieces: 2,
                          points: 2,
                          name: 'PET',
                          pic: 'assets/im1.png',
                        ),
                        Box(
                          pieces: 3,
                          points: 3,
                          name: 'PE-HD',
                          pic: 'assets/im2.png',
                        ),
                        Box(
                          pieces: 5,
                          points: 10,
                          name: 'PVC',
                          pic: 'assets/im3.png',
                        ),
                        Box(
                          pieces: 1,
                          points: 1,
                          name: 'PE-LD',
                          pic: 'assets/im4.png',
                        ),
                        Box(
                          pieces: 10,
                          points: 20,
                          name: 'PP',
                          pic: 'assets/im5.png',
                        ),
                        Box(
                          pieces: 10,
                          points: 20,
                          name: 'PS',
                          pic: 'assets/im6.png',
                        ),
                        Box(
                          pieces: 10,
                          points: 20,
                          name: 'O',
                          pic: 'assets/im7.png',
                        ),
                        Button(),
                      ],
                    ),
                  )),
            ),
            footer(),
          ],
        ),
      ),
    );
  }
}

var sum = 0;

class Box extends StatefulWidget {
  final int pieces;
  final int points;
  final String pic;
  final String name;

  const Box(
      {Key? key,
      required this.pieces,
      required this.points,
      required this.pic,
      required this.name})
      : super(key: key);

  @override
  State<Box> createState() => _BoxState(
      pieces: this.pieces, points: this.points, pic: this.pic, name: this.name);
}

class _BoxState extends State<Box> {
  int pieces;
  int points;
  String pic;
  String name;

  _BoxState({
    required this.pieces,
    required this.points,
    required this.pic,
    required this.name,
  });

  int sumpoint() {
    sum += points;
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
        // padding: EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 30.0),
        width: deviceWidth * 0.9,
        height: deviceHeight * 0.125,
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
        child:   
            Row(
              
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ibutton(),
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      pic,
                      scale: 0.1,
                      width: 50,
                    )),
                Container(
                  width: 125,
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ),
                addbut(),
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
      width: 100,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('ADD'),
        style: ElevatedButton.styleFrom(
          primary: Color(0xffFF9F1D),
        ),
      ),
    );
  }
}

class addbut extends StatefulWidget {
  const addbut({Key? key}) : super(key: key);

  @override
  State<addbut> createState() => _addbutState();
}

class _addbutState extends State<addbut> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  void _decreasement() {
    setState(() {
      if (_counter != 0) {
        --_counter;
      } else {
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Color(0xffFF9F1D)),
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffFF9F1D),
      ),
      width: 125.0,
      height: 28.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          IconButton(
            onPressed: _decreasement,
            icon: Icon(Icons.remove_circle),
            color: Color.fromARGB(255, 255, 255, 255),
            padding: EdgeInsets.only(bottom: 9.0),
          ),
          Text('$_counter', style: TextStyle(color: Colors.white, fontSize: 20)),
          IconButton(
            onPressed: _increment,
            icon: Icon(Icons.add_circle),
            color: Color.fromARGB(255, 255, 255, 255),
            padding: EdgeInsets.only(bottom: 9.0),
          ),

        ],
      ),
    );
  }
}

class ibutton extends StatelessWidget {
  const ibutton({Key? key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      // alignment: Alignment.topLeft,
      child: IconButton(
      onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                actions: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context, 'Close'),
                          icon: Icon(Icons.close),
                          color: Colors.black,
                        ),
                      ),
                      ImageSlideshow(
                          width: deviceWidth * 0.7,
                          height: deviceHeight * 0.4,
                          indicatorColor: Color(0xffFF9F1D),
                          children: [
                            picshow(
                                namepic: 'Butter', pic: 'assets/butter.png'),
                            picshow(namepic: 'Coke', pic: 'assets/coke.png'),
                            picshow(namepic: 'Sauce', pic: 'assets/sauce.png'),
                          ]),
                    ],
                  ),
                ],
                // content: const Text('asd'),
              )),
      icon: Icon(
        Icons.info_outline,
        color: Colors.black,
        size: 20.0,
      ),
    ),
    );
    
  }
}

class picshow extends StatelessWidget {
  const picshow({Key? key, required this.namepic, required this.pic})
      : super(key: key);
  final String namepic;
  final String pic;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              '$namepic',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Image.asset(
            '$pic',
            fit: BoxFit.cover,
            width: deviceWidth * 0.6,
            height: deviceHeight * 0.3,
          ),
        ],
      ),
    );
  }
}
