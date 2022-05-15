import 'dart:async';
// import 'dart:ffi';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:intl/intl.dart';

import 'main.dart';

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
                          name: 'PET',
                          pic: 'assets/im1.png',
                          typenum: 0,
                        ),
                        Box(
                          name: 'PE-HD',
                          pic: 'assets/im2.png',
                          typenum: 1,
                        ),
                        Box(
                          name: 'PVC',
                          pic: 'assets/im3.png',
                          typenum: 2,
                        ),
                        Box(
                          name: 'PE-LD',
                          pic: 'assets/im4.png',
                          typenum: 3,
                        ),
                        Box(
                          name: 'PP',
                          pic: 'assets/im5.png',
                          typenum: 4,
                        ),
                        Box(
                          name: 'PS',
                          pic: 'assets/im6.png',
                          typenum: 5,
                        ),
                        Box(
                          name: 'O',
                          pic: 'assets/im7.png',
                          typenum: 6,
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
  final String pic;
  final String name;
  final int typenum;

  const Box(
      {Key? key, required this.pic, required this.name, required this.typenum})
      : super(key: key);

  @override
  State<Box> createState() =>
      _BoxState(pic: this.pic, name: this.name, typenum: this.typenum);
}

class _BoxState extends State<Box> {
  String pic;
  String name;
  int typenum;

  _BoxState({
    required this.pic,
    required this.name,
    required this.typenum,
  });

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
          ibutton(typenum: typenum),
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
          addbut(
            typenum: typenum,
          ),
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

var total = 0;
List<dynamic> pointdb = [0, 0, 0, 0, 0, 0, 0];

class _ButtonState extends State<Button> {
  static List<int> point = [0, 0, 0, 0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    return Container(
      width: 100,
      child: ElevatedButton(
        onPressed: () {
          var newtype = _addbutState.type;
          // print(_addbutState.type);
          point = [
            (_addbutState.type[0] * 2),
            (_addbutState.type[1] * 3),
            (_addbutState.type[2] * 6),
            (_addbutState.type[3] * 5),
            (_addbutState.type[4] * 4),
            (_addbutState.type[5] * 3),
            (_addbutState.type[6] * 8),
          ];
          void checkdb() async {
            bool c = false;
            var a =
                FirebaseFirestore.instance.collection('UserRec').snapshots();
            QuerySnapshot<Map<String, dynamic>> b = await a.first;
            final user = FirebaseAuth.instance.currentUser!;
            var uid = user.uid;
            b.docs.forEach((e) {
              if (e.id == '$uid $date') {
                updatepiece();
                print('a');
                c = true;
              }
            });
            if (c == false) {
              recordpiece(type: _addbutState.type, point: point, total: total);
              _addbutState.type = [0, 0, 0, 0, 0, 0, 0];
              print('n');
            }
          }

          ;

          checkdb();

          Navigator.pushNamed(context, '/recommendation', arguments: point);
        },
        child: Text('ADD'),
        style: ElevatedButton.styleFrom(
          primary: Color(0xffFF9F1D),
        ),
      ),
    );
  }
  // var total;
  // void newtotalpoint(){
  //   for(var i = 0; i < 7; i++) {
  //    total += _addbutState.type[i];
  //   }
  // }
  // void totalpoint(){
  //   for(var i=0 ; i<7; i++){
  //     total +=
  //   }
  // }

  void updatepiece() async {
    var intpiece = await readpiece();
    for (int i = 0; i < 7; i++) {
      intpiece[i] += _addbutState.type[i];
    }
    List<int> newpoint = [
      (intpiece[0] * 2),
      (intpiece[1] * 3),
      (intpiece[2] * 6),
      (intpiece[3] * 5),
      (intpiece[4] * 4),
      (intpiece[5] * 3),
      (intpiece[6] * 8),
    ];

    // print(_addbutState.type);
    await recordpiece(type: intpiece, point: newpoint, total: total);
    _addbutState.type = [0, 0, 0, 0, 0, 0, 0];
  }

  var date = DateFormat.MMMd().format(new DateTime.now());
  Future<List<int>> readpiece() async {
    final user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    List<int> pointdbint = [];
    var dbpie = FirebaseFirestore.instance.collection('UserRec').snapshots();
    QuerySnapshot<Map<String, dynamic>> recpiece = await dbpie.first;
    var test;
    recpiece.docs.forEach((e) {
      if (e.id == '$uid $date') {
        test = e.data();
        pointdb = e.data()['allplasticpiece'];
        print(pointdb);
        pointdbint = pointdb.cast<int>();
        // print(test);
      }
    });
    return pointdbint;
    //.map((snapshot) => snapshot.docs.map((e) => print(e)))
  }

  Future recordpiece(
      {required List<int> type,
      required List<int> point,
      required int total}) async {
    final user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    for (var i = 0; i < 7; i++) {
      total += point[i];
    }
    var date = DateFormat.MMMd().format(new DateTime.now());
    final piece =
        FirebaseFirestore.instance.collection('UserRec').doc('$uid $date');
    final json = {
      'allplasticpiece': type,
      'allplasticpoint': point,
      'Date': new DateTime.now(),
      'userId': uid,
      'totalpoint': total,
    };
    await piece.set(json);
    print(_addbutState.type);
  }
}

class addbut extends StatefulWidget {
  const addbut({Key? key, required this.typenum}) : super(key: key);
  final int typenum;
  @override
  State<addbut> createState() => _addbutState(typenum: this.typenum);
}

class _addbutState extends State<addbut> {
  int _counter = 0;
  int typenum;

  _addbutState({required this.typenum});

  static List<int> type = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ].cast<int>();

  void _increment() {
    setState(() {
      // ++_counter;
      type[typenum]++;
      print(type);
    });
  }

  void _decreasement() {
    setState(() {
      if (type[typenum] != 0) {
        // --_counter;
        type[typenum]--;
        print(type);
      } else {
        type[typenum] = 0;
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
          Text('${type[typenum]}',
              style: TextStyle(color: Colors.white, fontSize: 20)),
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
  ibutton({Key? key, required this.typenum}) : super(key: key);
  final int typenum;
  List<List<Widget>> type = [
    [
      picshow(namepic: 'PET', pic: 'assets/im1.png'),
      picshow(namepic: 'peanut butter jar', pic: 'assets/butter.png'),
      picshow(namepic: 'soda bottle', pic: 'assets/Coke.png'),
      picshow(namepic: 'water bottle', pic: 'assets/im11.png'),
      picshow(namepic: 'mouth wash bottle', pic: 'assets/im12.png'),
      picshow(namepic: 'condiment bottle', pic: 'assets/im13.png'),
      picshow(namepic: 'frozen food packaging', pic: 'assets/im14.png'),
      picshow(namepic: 'bakery product', pic: 'assets/im15.png'),
    ],
    [
      picshow(namepic: 'PE-HD', pic: 'assets/im2.png'),
      picshow(namepic: 'milk jugs', pic: 'assets/im21.png'),
      picshow(namepic: 'cleaner bottles', pic: 'assets/im22.png'),
      picshow(namepic: 'shampoo bottles', pic: 'assets/im23.png'),
      picshow(namepic: 'trash bags', pic: 'assets/im24.png'),
      picshow(namepic: 'shopping bags', pic: 'assets/im25.png'),
      picshow(namepic: 'cereal box liners', pic: 'assets/im26.png'),
    ],
    [
      picshow(namepic: 'PVC', pic: 'assets/im3.png'),
      picshow(namepic: 'pipes', pic: 'assets/im31.png'),
      picshow(namepic: 'wire jacketing', pic: 'assets/im32.png'),
      picshow(namepic: 'clear food packaging', pic: 'assets/im33.png'),
      picshow(namepic: 'wire rope', pic: 'assets/im34.png'),
      picshow(namepic: 'medical equipment', pic: 'assets/im35.png'),
      picshow(namepic: 'siding', pic: 'assets/im36.png'),
      picshow(namepic: 'windows', pic: 'assets/im37.png'),
    ],
    [
      picshow(namepic: 'PE-LD', pic: 'assets/im4.png'),
      picshow(namepic: 'squeezable bottles', pic: 'assets/im41.png'),
      picshow(namepic: 'bread bags', pic: 'assets/im42.png'),
      picshow(namepic: 'carpet', pic: 'assets/im43.png'),
      picshow(namepic: 'plastic film', pic: 'assets/im44.png'),
      picshow(namepic: 'tote bags', pic: 'assets/im45.png'),
      picshow(namepic: 'ziplock bags', pic: 'assets/im46.png'),
    ],
    [
      picshow(namepic: 'PP', pic: 'assets/im5.png'),
      picshow(namepic: 'straws', pic: 'assets/im51.png'),
      picshow(namepic: 'plastic furniture', pic: 'assets/im52.png'),
      picshow(namepic: 'yogurt containers', pic: 'assets/im53.png'),
      picshow(namepic: 'hangers', pic: 'assets/im54.png'),
      picshow(namepic: 'butter tubs', pic: 'assets/im55.png'),
      picshow(namepic: 'tupperwear', pic: 'assets/im56.png'),
    ],
    [
      picshow(namepic: 'PS', pic: 'assets/im6.png'),
      picshow(namepic: 'disposable plates', pic: 'assets/im61.png'),
      picshow(namepic: 'meat trays', pic: 'assets/im62.png'),
      picshow(namepic: 'egg cartons', pic: 'assets/im63.png'),
      picshow(namepic: 'clear pill bottles', pic: 'assets/im64.png'),
      picshow(namepic: 'packing foam ', pic: 'assets/im65.png'),
      picshow(namepic: 'plastic cutlery', pic: 'assets/im66.png'),
      picshow(namepic: 'disposable cups', pic: 'assets/im67.png'),
    ],
    [
      picshow(namepic: 'O', pic: 'assets/im7.png'),
      picshow(namepic: 'sunglasses', pic: 'assets/im71.png'),
      picshow(namepic: 'CDs', pic: 'assets/im72.png'),
      picshow(namepic: 'baby bottles', pic: 'assets/im73.png'),
      picshow(namepic: 'water coolers bottle', pic: 'assets/im74.png'),
      picshow(namepic: 'headlight lenses', pic: 'assets/im75.png'),
    ],
  ];

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
                            height: deviceHeight * 0.5,
                            indicatorColor: Color(0xffFF9F1D),
                            children: [
                              for (var i = 0; i < type[typenum].length; i++)
                                type[typenum][i]
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
            fit: BoxFit.contain,
            width: deviceWidth * 0.6,
            height: deviceHeight * 0.4,
          ),
        ],
      ),
    );
  }
}
