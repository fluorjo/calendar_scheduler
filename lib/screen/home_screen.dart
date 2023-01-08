import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/const/colors.dart';

import 'package:provider/provider.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';

class HomeScreen extends StatelessWidget {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();
    final selectedDate = provider.selectedDate;
    final schedules = provider.cache[selectedDate] ?? [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            //배경 탭했을 때 bottomsheet 닫기
            builder: (_) => ScheduleBottomSheet(
              selectedDate: selectedDate,
            ),
            isScrollControlled: true,
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          MainCalendar(
            selectedDate: selectedDate,
            onDaySelected: (selectedDate, focusedDate) =>
                onDaySelected(selectedDate, focusedDate, context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TodayBanner(
            selectedDate: selectedDate,
            count: schedules.length,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];

                return Dismissible(
                  key: ObjectKey(schedule.id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (DismissDirection direction) {
                    provider.deleteSchedule(
                        date: selectedDate, id: schedule.id); // ➊
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 8.0, right: 8.0),
                    child: ScheduleCard(
                      startTime: schedule.startTime,
                      endTime: schedule.endTime,
                      content: schedule.content,
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  void onDaySelected(
    DateTime selectedDate,
    DateTime focusedDate,
    BuildContext context,
  ) {
    final provider = context.read<ScheduleProvider>();
    provider.changeSelectedDate(
      date: selectedDate,
    );
    provider.getSchedules(date: selectedDate);
  }
}
