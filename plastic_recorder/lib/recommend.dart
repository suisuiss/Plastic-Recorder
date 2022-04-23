import 'package:flutter/material.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:intl/intl.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:page_view_indicators/animated_circle_page_indicator.dart';

class Recommend extends StatefulWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  State<Recommend> createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> _pageNotifier = new ValueNotifier<int>(0);
    int test = 0;

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

    final controller = PageController(initialPage: 1);

    var bottlesCard = RecommendCard(
        'Plastic Bottles',
        'assets/bottles.png',
        'Small plastic bottles might be convenient, but they are even more wasteful than large plastic bottles. As an alternative, you should try using refillable bottles instead of single use. You can also use blah blah and blah blah for an even greener option...',
        UniqueKey());

    List<Widget> totalCards = <Widget>[bottlesCard, bottlesCard, bottlesCard];

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
                        height: 410,
                        width: 300,
                        child: PageView(
                          controller: controller,
                          children: totalCards,
                          onPageChanged: (index) {
                            setState(() {
                              _pageNotifier.value = index;
                              print(_pageNotifier.value);
                            });
                          },
                        ),
                      ),
                      Text(_pageNotifier.value.toString()),
                      Center(
                        child: CirclePageIndicator(
                          currentPageNotifier: _pageNotifier,
                          itemCount: totalCards.length,
                        ),
                      ),
                    ],
                  )),
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

class RecommendCard extends StatelessWidget {
  const RecommendCard(this.title, this.imagePath, this.desc, Key? key)
      : super(key: key);

  final String title;
  final String imagePath;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 410,
      width: 400,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none),
              child: Text(
                title,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Image.asset(
                  imagePath,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  decoration: TextDecoration.none),
              child: Text(
                desc,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
