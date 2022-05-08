import 'package:flutter/material.dart';
import 'package:plastic_recorder/add_screen.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:intl/intl.dart';

class Today extends StatelessWidget {
  
  Today({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final calDate = ModalRoute != null? ModalRoute.of(context)!.settings.arguments : DateTime.now();
    final dateFormat = DateFormat('MMMd');
    DateTime? showingDate;
      if(calDate == null){
       showingDate = DateTime.now();
    }else{
      showingDate = DateTime.parse(calDate.toString());
    }
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
                         child: Text(dateFormat.format(showingDate), style: TextStyle(fontSize: 30)),
                           
                                                     
                          // child:Text(DateFormat('MMMd').format(calDate) ,
                          //     style: TextStyle(
                          //         fontSize: 30,
                          //         color: Colors.black,
                          //         decoration: TextDecoration.none))
                        ),
                        Box(
                          pieces: 2,
                          points: 2,
                          name: 'PET',
                          pic: 'assets/im1.png',
                          namepic: 'PET',
                          picI: 'assets/im1.png',
                        ),
                        Box(
                          pieces: 3,
                          points: 3,
                          name: 'PE-HD',
                          pic: 'assets/im2.png',
                           namepic: 'PE-HD',
                          picI: 'assets/im2.png',
                        ),
                        Box(
                          pieces: 5,
                          points: 10,
                          name: 'PVC',
                          pic: 'assets/im3.png',
                           namepic: 'PVC',
                          picI: 'assets/im3.png',
                        ),
                        Box(
                          pieces: 1,
                          points: 1,
                          name: 'PE-LD',
                          pic: 'assets/im4.png',
                           namepic: 'PE-LD',
                          picI: 'assets/im4.png',
                        ),
                        Box(
                          pieces: 10,
                          points: 20,
                          name: 'PP',
                          pic: 'assets/im5.png',
                           namepic: 'PP',
                          picI: 'assets/im5.png',
                        ),
                        Box(
                          pieces: 10,
                          points: 20,
                          name: 'PS',
                          pic: 'assets/im6.png',
                           namepic: 'PS',
                          picI: 'assets/im6.png',
                        ),
                        Box(
                          pieces: 10,
                          points: 20,
                          name: 'O',
                          pic: 'assets/im7.png',
                           namepic: 'O',
                          picI: 'assets/im7.png',
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Total:   $sum   point(s)',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                            textAlign: TextAlign.right,
                          ),
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
  final String namepic;
  final String picI;

  const Box(
      {Key? key,
      required this.pieces,
      required this.points,
      required this.pic,
      required this.name,
      required this.namepic,
      required this.picI})
      : super(key: key);

  @override
  State<Box> createState() => _BoxState(
      pieces: this.pieces, points: this.points, pic: this.pic, name: this.name, namepic: this.namepic, picI: this.picI);
}

class _BoxState extends State<Box> {
  int pieces;
  int points;
  String pic;
  String name;
  String namepic;
  String picI;

  _BoxState({
    required this.pieces,
    required this.points,
    required this.pic,
    required this.name,
    required this.namepic,
    required this.picI,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ibutton(namepic: '$namepic', pic: '$picI',),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(5.0),
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
                  margin: const EdgeInsets.only(top: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Color(0xffFF9F1D)),
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFF9F1D),
                  ),
                  width: 125.0,
                  height: 28.0,
                  child: Text(
                    '$points point(s) $sumpoint()',
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
        onPressed: () {
          Navigator.pushNamed(context, '/compare');
        },
        child: Text('Compare Usage'),
        style: ElevatedButton.styleFrom(
          primary: Color(0xffFF9F1D),
        ),
      ),
    );
  }
}

class ibutton extends StatelessWidget {
  const ibutton({Key? key, required this.namepic , required this.pic}) : super(key: key);
  final String pic;
  final String namepic;

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
                        picshow(namepic: '$namepic' , pic: '$pic'),
                        
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
            // margin: EdgeInsets.only(bottom: 10),
            child: Image.asset(
              '$pic',
              // fit: BoxFit.cover,
              scale: 0.3,
              width: deviceWidth * 0.6,
              height: deviceHeight * 0.3,
            ),
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child:Text(
            '$namepic',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ), 
          )
          
        ],
      ),
    );
  }
}
