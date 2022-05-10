import 'package:cloud_firestore/cloud_firestore.dart';
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
    final _currentPageNotifier = ValueNotifier<int>(0);
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

    final controller = PageController(initialPage: 0);

    List<Widget> totalCards = <Widget>[
      RecommendCard(
          'Type 1: PET',
          'assets/im1.png',
          'Polyethylene terephthalate or PET or PETE  is the most common thermoplastic polymer resin of the polyester family. PET products might be convenient, but they are wasteful and can be used only once. As an alternative, you should try using refillable products instead of single use. You can also use biodegradable product  for an even greener option.',
          UniqueKey()),
      RecommendCard(
          'Type 2: PE-HD',
          'assets/im2.png',
          'High-density polyethylene or PE-HD or HDPE is a thermoplastic polymer produced from the monomer ethylene. his plastic can be easily reused and recycled up to 10 times. You can reuse it as refillable products.',
          UniqueKey()),
      RecommendCard(
          'Type 3: PVC',
          'assets/im3.png',
          'Polyvinyl chloride or PVC is the world\'s third-most widely produced synthetic polymer of plastic. It is one of the least recyclable plastics due to the variety of additives in the material. However, there are many alternatives to PVC. For example, RIVERCYCLON is 100% recyclable. RIVERCYCLON® is made with a single, non-toxic polymer, derived from the most commonly recycled plastic worldwide with reasonable prices.',
          UniqueKey()),
      RecommendCard(
          'Type 4: PE-LD',
          'assets/im4.png',
          'Low-density polyethylene or PE-LD or LDPE is a thermoplastic made from the monomer ethylene. A very small amount is recyclable. You can reuse PE-LD products a few times.',
          UniqueKey()),
      RecommendCard(
          'Type 5: PP',
          'assets/im5.png',
          'Polypropylene or PP is a thermoplastic polymer used in a wide variety of applications. It is produced via chain-growth polymerization from the monomer propylene. Anyhow, The Californian-based company Cereplast claims its biopropylene resin is an industry first and could replace traditional PP in the vast majority of applications.',
          UniqueKey()),
      RecommendCard(
          'Type 6: PS',
          'assets/im6.png',
          'Polystyrene or PS s a synthetic aromatic hydrocarbon polymer made from the monomer known as styrene. Polystyrene is a lightweight plastic that is cheap to produce. It can be made into a solid material or foam. Most PS products can be used only once. Polystyrene can be recycled but it is not widely accepted everywhere, as a smaller number of factories accept it. You can use biodegradable products or products that are reusable.',
          UniqueKey()),
      RecommendCard(
          'Type 7: O/OTHER',
          'assets/im7.png',
          'OTHER or O is other plastics, such as acrylic, nylon, polycarbonate, and polylactic acid (a bioplastic also known as PLA), and multilayer combinations of different plastics. Number 7 plastics are not typically recycled as they\'re mostly specialty produced in limited volumes. It is suggested that these items are not reused unless labeled with “PLA” (aka Polylactic acid). This means the product is compostable and should not be placed in the recycling bin.',
          UniqueKey()),
    ];

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
                        height: height * 0.6,
                        width: width * 0.8,
                        child: PageView.builder(
                            itemCount: totalCards.length,
                            controller: controller,
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: totalCards[index],
                              );
                            },
                            onPageChanged: (int index) {
                              _currentPageNotifier.value = index;
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                          child: CirclePageIndicator(
                            currentPageNotifier: _currentPageNotifier,
                            itemCount: totalCards.length,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Respond to button press
                          Navigator.pushNamed(context, '/today');
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFFFF9F1D)),
                        child: Text('Continue'),
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
            Expanded(
                child: SingleChildScrollView(
              child: DefaultTextStyle(
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
            )),
          ],
        ),
      ),
    );
  }
}
