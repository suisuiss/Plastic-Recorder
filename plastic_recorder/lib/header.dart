import 'package:flutter/material.dart';

class header extends StatefulWidget {
  const header({Key? key}) : super(key: key);

  @override
  State<header> createState() => _headerState();
}

class _headerState extends State<header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [           
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
              Icons.chevron_left_outlined,
              size: 45,
              color: Color(0xffFF9F1D),
            ),
            ),
            GestureDetector(
              onTap: () {
                 Navigator.pushNamed(context, '/profile' );
              },
              child: Icon(
              Icons.account_circle,
              size: 60,
            ),
            )
          ]),
        ]),
      ),
    );
  }
}
