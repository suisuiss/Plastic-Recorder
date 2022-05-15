import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:plastic_recorder/add_screen.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plastic_recorder/main.dart';

class Today extends StatefulWidget {
  const Today({Key? key}) : super(key: key);

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
   static bool done = false;
  Future? checkdb1;
  Future? gettt;
  @override
  void initState() {
    var calDate;
    Future.delayed(Duration.zero, () {
      setState(() {
        calDate = ModalRoute != null
            ? ModalRoute.of(context)!.settings.arguments
            : DateTime.now();

        if (calDate == null) {
          calDate = DateTime.now();
        }
      });

      print(calDate.toString());

      final dateFormat = DateFormat('MMMd');
      DateTime? showingDate;
      if (calDate == null) {
        showingDate = DateTime.now();
      } else {
        showingDate = DateTime.parse(calDate.toString());
      }

      checkdb1 = check(showingDate);
      gettt = getpiceandpoint(showingDate);
    });
    super.initState();
  }

  List<int> pointset = [0, 0, 0, 0, 0, 0, 0].cast<int>();
  List<int> pieceset = [0, 0, 0, 0, 0, 0, 0].cast<int>();
  bool checkbool = false;
  var totaldb;
  var piecedb;
  var pointdb;
  // bool checkbool = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    final calDate = ModalRoute != null
        ? ModalRoute.of(context)!.settings.arguments
        : DateTime.now();
    final dateFormat = DateFormat('MMMd');
    DateTime? showingDate;
    if (calDate == null) {
      showingDate = DateTime.now();
    } else {
      showingDate = DateTime.parse(calDate.toString());
    }
    var now = new DateTime.now();
    print(DateFormat.MMMd().format(showingDate));
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
                          child: Text(dateFormat.format(showingDate),
                              style: TextStyle(fontSize: 30)),
                        ),
                        FutureBuilder<dynamic>(
                            future: gettt,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Column(
                                  children: [
                                    Box(
                                      pieces:
                                          piecedb[0] == null ? 0 : piecedb[0],
                                      points:
                                          pointdb[0] == null ? 0 : pointdb[0],
                                      name: 'PET',
                                      pic: 'assets/im1.png',
                                      picI: 'assets/im1.png',
                                      namepic:
                                          'Examples: water bottle, peanut butter jar, condiment bottle, soda bottles, mouth wash bottle, salad dressing,  frozen foods packaging, bakery products',
                                      typenum: 0,
                                    ),
                                    Box(
                                      pieces:
                                          piecedb[1] == null ? 0 : piecedb[1],
                                      points:
                                          pointdb[1] == null ? 0 : pointdb[1],
                                      name: 'PE-HD',
                                      pic: 'assets/im2.png',
                                      picI: 'assets/im2.png',
                                      namepic:
                                          'Examples: milk jugs, household cleaner bottles, shampoo bottles, trash bags,shopping bags, cereal box liners ',
                                      typenum: 1,
                                    ),
                                    Box(
                                      pieces:
                                          piecedb[2] == null ? 0 : piecedb[2],
                                      points:
                                          pointdb[2] == null ? 0 : pointdb[2],
                                      name: 'PVC',
                                      pic: 'assets/im3.png',
                                      picI: 'assets/im3.png',
                                      namepic:
                                          'Examples: pipes, wire jacketing, clear food packaging, wire rope, medical equipment, siding, windows',
                                      typenum: 2,
                                    ),
                                    Box(
                                      pieces:
                                          piecedb[3] == null ? 0 : piecedb[3],
                                      points:
                                          pointdb[3] == null ? 0 : pointdb[3],
                                      name: 'PE-LD',
                                      pic: 'assets/im4.png',
                                      picI: 'assets/im4.png',
                                      namepic:
                                          'Examples: squeezable bottles, bread bags, carpet, plastic film, tote bags, package cushioning, ziplock bags',
                                      typenum: 3,
                                    ),
                                    Box(
                                      pieces:
                                          piecedb[4] == null ? 0 : piecedb[4],
                                      points:
                                          pointdb[4] == null ? 0 : pointdb[4],
                                      name: 'PP',
                                      pic: 'assets/im5.png',
                                      picI: 'assets/im5.png',
                                      namepic:
                                          'Examples: straws, plastic furniture, yogurt containers, hangers, butter tubs, tupperwear,',
                                      typenum: 4,
                                    ),
                                    Box(
                                      pieces:
                                          piecedb[5] == null ? 0 : piecedb[5],
                                      points:
                                          pointdb[5] == null ? 0 : pointdb[5],
                                      name: 'PS',
                                      pic: 'assets/im6.png',
                                      picI: 'assets/im6.png',
                                      namepic:
                                          'Examples: disposable plates, meat trays, egg cartons, clear pill bottles, packing foam, plastic cutlery, disposable cups',
                                      typenum: 5,
                                    ),
                                    Box(
                                      pieces:
                                          piecedb[6] == null ? 0 : piecedb[6],
                                      points:
                                          pointdb[6] == null ? 0 : pointdb[6],
                                      name: 'O',
                                      pic: 'assets/im7.png',
                                      picI: 'assets/im7.png',
                                      namepic:
                                          'Examples: sunglasses, CDs, baby bottles, water coolers bottle, headlight lenses',
                                      typenum: 6,
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            'Total:   $total  point(s)',
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

    // class _dataState extends State<data> {
    //   @override
    //   Widget build(BuildContext context) {
    //     return Container(
    //
    //     );
    //   }
    // }
  }

  var data;
  var piece;
  var point;
  var total = 0;
  Future getpiceandpoint(DateTime date1) async {
    final user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    var date = DateFormat.MMMd().format(date1);
    var dbpp = FirebaseFirestore.instance.collection('UserRec').snapshots();
    QuerySnapshot<Map<String, dynamic>> recpp = await dbpp.first;
    recpp.docs.forEach((e) {
      if (e.id == '$uid $date') {
        piece = e.data()['allplasticpiece'];
        point = e.data()['allplasticpoint'];
        total = e.data()['totalpoint'];
        setState(() {
          totaldb = total;
          piecedb = piece.cast<int>();
          pointdb = point.cast<int>();
        });
      }
      done = true;
      print('--------');
      print(totaldb);
      print(piecedb);
      print(pointdb);
    });
  }

  Future check(DateTime date1) async {
    final user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    bool c = false;
    var date = DateFormat.MMMd().format(date1);
    var checkdb = FirebaseFirestore.instance.collection('UserRec').snapshots();
    QuerySnapshot<Map<String, dynamic>> checkdoc = await checkdb.first;
    checkdoc.docs.forEach((e) {
      if (e.id == '$uid $date') {
        print('aaaaa');
        getpiceandpoint(date1);
        c = true;
      }
    });
    if (c == false) {
      print('ffff');
      await recordpiece([0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], 0, date1);
      getpiceandpoint(date1);
    }
    return done;
  }

  Future recordpiece(
      List<int> type, List<int> point, int total, DateTime date1) async {
    final user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;
    var date = DateFormat.MMMd().format(date1);
    final piece =
        FirebaseFirestore.instance.collection('UserRec').doc('$uid $date');
    final json = {
      'allplasticpiece': type,
      'allplasticpoint': point,
      'Date': date1,
      'userId': uid,
      'totalpoint': total,
    };
    await piece.set(json);
  }
}

class Box extends StatefulWidget {
  final int pieces;
  final int points;
  final String pic;
  final String name;
  final String namepic;
  final String picI;
  final int typenum;

  const Box(
      {Key? key,
      required this.pieces,
      required this.points,
      required this.pic,
      required this.name,
      required this.namepic,
      required this.picI,
      required this.typenum})
      : super(key: key);

  @override
  State<Box> createState() => _BoxState(
        pieces: this.pieces,
        points: this.points,
        pic: this.pic,
        name: this.name,
        namepic: this.namepic,
        picI: this.picI,
        typenum: this.typenum,
      );
}

class _BoxState extends State<Box> {
  int pieces;
  int points;
  String pic;
  String name;
  String namepic;
  String picI;
  int typenum;
  // static int piecedb;
  // static int pointdb;

  _BoxState({
    required this.pieces,
    required this.points,
    required this.pic,
    required this.name,
    required this.namepic,
    required this.picI,
    required this.typenum,
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
          ibutton(
            typenum: typenum,
          ),
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
          Navigator.pushNamed(context, '/compare',
              arguments: ModalRoute != null
                  ? ModalRoute.of(context)!.settings.arguments
                  : DateTime.now());
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
  ibutton({Key? key, required this.typenum}) : super(key: key);
  final int typenum;
  List<List<Widget>> type = [
    [
      picshow(namepic: 'PET', pic: 'assets/PET.png'),
      picshow(namepic: 'peanut butter jar', pic: 'assets/butter.png'),
      picshow(namepic: 'soda bottle', pic: 'assets/Coke.png'),
      picshow(namepic: 'water bottle', pic: 'assets/im11.png'),
      picshow(namepic: 'mouth wash bottle', pic: 'assets/im12.png'),
      picshow(namepic: 'condiment bottle', pic: 'assets/im13.png'),
      picshow(namepic: 'frozen food packaging', pic: 'assets/im14.png'),
      picshow(namepic: 'bakery product', pic: 'assets/im15.png'),
    ],
    [
      picshow(namepic: 'PE-HD', pic: 'assets/PE-HD.png'),
      picshow(namepic: 'milk jugs', pic: 'assets/im21.png'),
      picshow(namepic: 'cleaner bottles', pic: 'assets/im22.png'),
      picshow(namepic: 'shampoo bottles', pic: 'assets/im23.png'),
      picshow(namepic: 'trash bags', pic: 'assets/im24.png'),
      picshow(namepic: 'shopping bags', pic: 'assets/im25.png'),
      picshow(namepic: 'cereal box liners', pic: 'assets/im26.png'),
    ],
    [
      picshow(namepic: 'PVC', pic: 'assets/PVC.png'),
      picshow(namepic: 'pipes', pic: 'assets/im31.png'),
      picshow(namepic: 'wire jacketing', pic: 'assets/im32.png'),
      picshow(namepic: 'clear food packaging', pic: 'assets/im33.png'),
      picshow(namepic: 'wire rope', pic: 'assets/im34.png'),
      picshow(namepic: 'medical equipment', pic: 'assets/im35.png'),
      picshow(namepic: 'siding', pic: 'assets/im36.png'),
      picshow(namepic: 'windows', pic: 'assets/im37.png'),
    ],
    [
      picshow(namepic: 'PE-LD', pic: 'assets/PE-LD.png'),
      picshow(namepic: 'squeezable bottles', pic: 'assets/im41.png'),
      picshow(namepic: 'bread bags', pic: 'assets/im42.png'),
      picshow(namepic: 'carpet', pic: 'assets/im43.png'),
      picshow(namepic: 'plastic film', pic: 'assets/im44.png'),
      picshow(namepic: 'tote bags', pic: 'assets/im45.png'),
      picshow(namepic: 'ziplock bags', pic: 'assets/im46.png'),
    ],
    [
      picshow(namepic: 'PP', pic: 'assets/PP.png'),
      picshow(namepic: 'straws', pic: 'assets/im51.png'),
      picshow(namepic: 'plastic furniture', pic: 'assets/im52.png'),
      picshow(namepic: 'yogurt containers', pic: 'assets/im53.png'),
      picshow(namepic: 'hangers', pic: 'assets/im54.png'),
      picshow(namepic: 'butter tubs', pic: 'assets/im55.png'),
      picshow(namepic: 'tupperwear', pic: 'assets/im56.png'),
    ],
    [
      picshow(namepic: 'PS', pic: 'assets/PS.png'),
      picshow(namepic: 'disposable plates', pic: 'assets/im61.png'),
      picshow(namepic: 'meat trays', pic: 'assets/im62.png'),
      picshow(namepic: 'egg cartons', pic: 'assets/im63.png'),
      picshow(namepic: 'clear pill bottles', pic: 'assets/im64.png'),
      picshow(namepic: 'packing foam ', pic: 'assets/im65.png'),
      picshow(namepic: 'plastic cutlery', pic: 'assets/im66.png'),
      picshow(namepic: 'disposable cups', pic: 'assets/im67.png'),
    ],
    [
      picshow(namepic: 'O', pic: 'assets/O.png'),
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
