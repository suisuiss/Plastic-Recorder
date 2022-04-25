import 'package:flutter/material.dart';
import 'package:plastic_recorder/footer.dart';
import 'package:plastic_recorder/header.dart';
import 'package:table_calendar/table_calendar.dart';

const bgcolor = Color(0xffF6F6F8);
const yellow = Color.fromRGBO(255, 159, 29, 1);

class calender extends StatefulWidget {
  const calender({Key? key}) : super(key: key);

  @override
  State<calender> createState() => _calenderState();
}

class _calenderState extends State<calender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            header(),
            Expanded(
                child: Container(
                    child: Column(
              children: [
                Text('Calender', style: TextStyle(fontSize: 30)),
                SizedBox(height: 10), // identifier

                // date identifier
                //calender area
                TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2050),
                  headerVisible: true,
                  //calender format
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },

                  //selected day
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      print(selectedDay); // update `_focusedDay` here as well
                    });
                  },

                  //style
                  calendarStyle: CalendarStyle(
                      // tableBorder: ,

                      isTodayHighlighted: true,
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: yellow,
                      )),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                    ),
                    formatButtonVisible: false,
                    formatButtonTextStyle: TextStyle(color: Colors.white),
                    formatButtonDecoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ],
            ))),
            footer()
          ],
        ),
      ),
    );
  }
}
