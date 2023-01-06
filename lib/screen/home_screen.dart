import 'package:flutter/material.dart';
import 'package:calendar_scheduler/components/main_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_scheduler/components/schedule_card.dart';
import 'package:calendar_scheduler/components/today_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          MainCalendar(
            selectedDate: selectedDate,
            onDaySelected: onDaySelected,
          ),
          SizedBox(height: 8.0,),
          TodayBanner(selectedDate: selectedDate, count: 0,),
          SizedBox(height: 8.0,),
           ScheduleCard(startTime: 12, endTime: 14, content: '공부')
        ]),
      ),
    );
  }

  void onDaySelected(DateTime seletedDate, DateTime focusedDate) {
    setState(() {
      selectedDate = seletedDate;
    });
  }
}
