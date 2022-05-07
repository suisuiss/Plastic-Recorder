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

final user = FirebaseAuth.instance.currentUser!;
var uid = user.uid;
final Stream<QuerySnapshot> records =
    FirebaseFirestore.instance.collection('test-record').snapshots();

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

    print('test');
    dataFuture = getPoints();
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
                  if (snapshot.connectionState == ConnectionState.done) {
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
                                    child:
                                        SimpleTimeSeriesChart.withSampleData(),
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
                                              formattedDate +
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
                    return TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        print(dataFuture.then((value) => print(value)));
                      },
                      child: Text('TextButton'),
                    );
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

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  bool animate = false;

  SimpleTimeSeriesChart(this.seriesList, {required this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2022, 5, 28), 10),
      new TimeSeriesSales(new DateTime(2022, 5, 29), 15),
      new TimeSeriesSales(new DateTime(2022, 5, 30), 11),
      new TimeSeriesSales(new DateTime(2022, 6, 1), 0),
      new TimeSeriesSales(new DateTime(2022, 6, 2), 20),
      new TimeSeriesSales(new DateTime(2022, 6, 3), 22),
      new TimeSeriesSales(new DateTime(2022, 6, 4), 15),
      new TimeSeriesSales(new DateTime(2022, 6, 5), 18),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

Future<int?> getPoints() async {
  int points = 0;
  var now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  var db = FirebaseFirestore.instance;

  /*final docRef = db.collection("test-record").get().then((event) {
    for (var doc in event.docs) {
      var dat = Record.fromJson(doc.data());
      //print("${doc.id} => ${doc.data()}");
      if (DateTime.fromMillisecondsSinceEpoch(dat.time.seconds * 1000) ==
          today) {
        points += dat.t1 * 2;
        points += dat.t2 * 3;
        points += dat.t3 * 6;
        points += dat.t4 * 5;
        points += dat.t5 * 4;
        points += dat.t6 * 3;
        points += dat.t7 * 8;
      }
    }
  });*/

  final docRef = db.collection("test-record").get();
  QuerySnapshot<Map<String, dynamic>> records = await docRef;

  records.docs.forEach((doc) {
    var dat = Record.fromJson(doc.data());
    //print("${doc.id} => ${doc.data()}");
    if (DateTime.fromMillisecondsSinceEpoch(dat.time.seconds * 1000) == today) {
      points += dat.t1 * 2;
      points += dat.t2 * 3;
      points += dat.t3 * 6;
      points += dat.t4 * 5;
      points += dat.t5 * 4;
      points += dat.t6 * 3;
      points += dat.t7 * 8;
    }
  });

  //await Future.delayed(Duration(milliseconds: 4000));

  print(points);
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
      uid: json['uid'] as String,
      time: json['date'] as Timestamp,
      t1: json['plastics'][0] as int,
      t2: json['plastics'][1] as int,
      t3: json['plastics'][2] as int,
      t4: json['plastics'][3] as int,
      t5: json['plastics'][4] as int,
      t6: json['plastics'][5] as int,
      t7: json['plastics'][6] as int,
    );
  }
}
