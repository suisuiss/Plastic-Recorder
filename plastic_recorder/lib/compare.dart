import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:plastic_recorder/add_screen.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:intl/intl.dart';
import 'package:flutter/animation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dart_date/dart_date.dart';
import 'package:plastic_recorder/today_screen.dart';

final Stream<QuerySnapshot> records =
    FirebaseFirestore.instance.collection('test-record').snapshots();
var calDate;

int points = 99;

class Compare extends StatefulWidget {
  const Compare({Key? key}) : super(key: key);

  @override
  State<Compare> createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  late Future<int?> dataFuture;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser!;
    var uid = user.uid;

    dataFuture = getPoints(DateTime.now());

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

      dataFuture = getPoints(showingDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Full screen width and height
    double width = MediaQuery.of(context).size.width;

    // Height (without SafeArea)
    var padding = MediaQuery.of(context).viewPadding;
    var now = new DateTime.now();
    String formattedDate = DateFormat('MMMd').format(now);

    int avg = 7;

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
            FutureBuilder<int?>(
                future: dataFuture,
                builder: (context, AsyncSnapshot<int?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: DefaultTextStyle(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    child: Text(
                                        'Compared to your past records...'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                    width: 1000,
                                    height: 400,
                                    child: SimpleTimeSeriesChart(),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: DefaultTextStyle(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    child: Text(
                                      'Compared to the global average...',
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.fill,
                                  child: Container(
                                    width: width,
                                    height: 400,
                                    //color: Colors.red,
                                    child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        children: <Widget>[
                                          Positioned(
                                            child: Container(
                                              child: FittedBox(
                                                child: Image.asset(
                                                  'assets/bottle_fill.png',
                                                  color: color.lerp(
                                                      snapshot.data! / avg),
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                              height: 37 +
                                                  (278 *
                                                      (snapshot.data! / avg)
                                                          .clamp(
                                                              0, 1)), //278 Max
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
                                              child: Image.asset(
                                                  'assets/divider.png'),
                                              width: 130,
                                              height: 50,
                                            ),
                                            bottom: 45 +
                                                (282 *
                                                    (snapshot.data! / avg)
                                                        .clamp(0, 1)), //Max 290
                                          ),
                                          Positioned(
                                            child: Container(
                                              child: DefaultTextStyle(
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    decoration:
                                                        TextDecoration.none),
                                                child: Text(
                                                  snapshot.data.toString(),
                                                ),
                                              ),
                                              width: 130,
                                              height: 32,
                                            ),
                                            bottom: 47 +
                                                (282 *
                                                    (snapshot.data! / avg)
                                                        .clamp(0, 1)), //Max 290
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
                                              DateFormat('MMMd')
                                                  .format(calDate)
                                                  .toString() +
                                              ', your plastic consumption is ',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: snapshot.data.toString(),
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFF9F1D),
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                            TextSpan(
                                              text: ' points, ',
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            TextSpan(
                                              text: (avg -
                                                      (snapshot.data?.toInt() ??
                                                          0))
                                                  .abs()
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFF9F1D),
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                            TextSpan(
                                              text: (snapshot.data! > avg
                                                  ? ' more than the average!'
                                                  : ' less than the average!'),
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
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Text('Loading...');
                  }
                }),

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

class SimpleTimeSeriesChart extends StatefulWidget {
  const SimpleTimeSeriesChart({Key? key}) : super(key: key);

  @override
  _SimpleTimeSeriesChartState createState() => _SimpleTimeSeriesChartState();
}

class _SimpleTimeSeriesChartState extends State<SimpleTimeSeriesChart> {
  bool animate = false;

  late Future<List<charts.Series<dynamic, DateTime>>> dataFuture;

  @override
  void initState() {
    super.initState();
    dataFuture = getPointsChart(DateTime.now());

    Future.delayed(Duration.zero, () {
      setState(() {
        calDate = ModalRoute != null
            ? ModalRoute.of(context)!.settings.arguments
            : DateTime.now();
      });

      final dateFormat = DateFormat('MMMd');
      DateTime? showingDate;
      if (calDate == null) {
        showingDate = DateTime.now();
      } else {
        showingDate = DateTime.parse(calDate.toString());
      }

      dataFuture = getPointsChart(showingDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataFuture,
        builder: (context,
            AsyncSnapshot<List<charts.Series<dynamic, DateTime>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return charts.TimeSeriesChart(
              snapshot.data!,
              animate: false,
              // Optionally pass in a [DateTimeFactory] used by the chart. The factory
              // should create the same type of [DateTime] as the data provided. If none
              // specified, the default creates local date time.
              dateTimeFactory: const charts.LocalDateTimeFactory(),
            );
          } else {
            return Text('Loading...');
          }
        });
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

Future<List<charts.Series<dynamic, DateTime>>> getPointsChart(
    DateTime day) async {
  final user = FirebaseAuth.instance.currentUser!;
  var uid = user.uid;

  var now = DateTime.now();
  var empty = TimeSeriesSales(day, 0);
  var points = [0, 0, 0, 0, 0, 0, 0];
  List<TimeSeriesSales> data = [
    empty,
    empty,
    empty,
    empty,
    empty,
    empty,
    empty
  ];

  var db = FirebaseFirestore.instance;

  final docRef = db.collection("UserRec").get();
  QuerySnapshot<Map<String, dynamic>> records = await docRef;

  records.docs.forEach((doc) {
    var dat = Record.fromJson(doc.data());
    if (dat.uid == uid) {
      for (int i = 0; i < 7; i++) {
        if (day.subtract(Duration(days: i)).isSameDay(
            DateTime.fromMillisecondsSinceEpoch(dat.time.seconds * 1000))) {
          points[i] += dat.t1 * 2;
          points[i] += dat.t2 * 3;
          points[i] += dat.t3 * 6;
          points[i] += dat.t4 * 5;
          points[i] += dat.t5 * 4;
          points[i] += dat.t6 * 3;
          points[i] += dat.t7 * 8;
        }
      }
    }
  });

  for (int i = 0; i < 7; i++) {
    data[i] = TimeSeriesSales(day.subtract(Duration(days: i)), points[i]);
  }

  /*data = [
    new TimeSeriesSales(new DateTime(2022, 5, 28), 10),
    new TimeSeriesSales(new DateTime(2022, 5, 29), 15),
    new TimeSeriesSales(new DateTime(2022, 5, 30), 11),
    new TimeSeriesSales(new DateTime(2022, 6, 1), 0),
    new TimeSeriesSales(new DateTime(2022, 6, 2), 20),
    new TimeSeriesSales(new DateTime(2022, 6, 3), 22),
    new TimeSeriesSales(new DateTime(2022, 6, 4), 15),
    new TimeSeriesSales(new DateTime(2022, 6, 5), 18),
  ];*/

  var result = [
    new charts.Series<TimeSeriesSales, DateTime>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TimeSeriesSales sales, _) => sales.time,
      measureFn: (TimeSeriesSales sales, _) => sales.sales,
      data: data,
    )
  ];

  return result;
}

Future<int?> getPoints(DateTime day) async {
  final user = FirebaseAuth.instance.currentUser!;
  var uid = user.uid;

  int points = 0;
  var now = DateTime.now();

  var db = FirebaseFirestore.instance;

  final docRef = db.collection("UserRec").get();
  QuerySnapshot<Map<String, dynamic>> records = await docRef;

  records.docs.forEach((doc) {
    var dat = Record.fromJson(doc.data());
    if (day.isSameDay(
            DateTime.fromMillisecondsSinceEpoch(dat.time.seconds * 1000)) &&
        dat.uid == uid) {
      points += dat.t1 * 2;
      points += dat.t2 * 3;
      points += dat.t3 * 6;
      points += dat.t4 * 5;
      points += dat.t5 * 4;
      points += dat.t6 * 3;
      points += dat.t7 * 8;
    }
  });

  return points;
}

class Record {
  final String uid;
  final Timestamp time;
  final int t1;
  final int t2;
  final int t3;
  final int t4;
  final int t5;
  final int t6;
  final int t7;

  const Record({
    required this.uid,
    required this.time,
    required this.t1,
    required this.t2,
    required this.t3,
    required this.t4,
    required this.t5,
    required this.t6,
    required this.t7,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      uid: json['userId'] as String,
      time: json['Date'] as Timestamp,
      t1: json['allplasticpiece'][0] as int,
      t2: json['allplasticpiece'][1] as int,
      t3: json['allplasticpiece'][2] as int,
      t4: json['allplasticpiece'][3] as int,
      t5: json['allplasticpiece'][4] as int,
      t6: json['allplasticpiece'][5] as int,
      t7: json['allplasticpiece'][6] as int,
    );
  }
}
