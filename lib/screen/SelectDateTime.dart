import 'package:flutter/material.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import '../res.dart';

class SelectDateTime extends StatefulWidget {
  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  int _radioValue = 0;

  @override
  void initState() {}

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          setState(() {});
          break;

        case 1:
          setState(() {});
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      Res.ic_back,
                      width: 16,
                      height: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "When would you like to start meal?",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 220,
                  child: ScrollableCleanCalendar(
                    selectedDateColor: AppConstant.appColor,
                    rangeSelectedDateColor:
                        AppConstant.appColor.withOpacity(0.6),
                    monthLabelStyle:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    dayWeekLabelStyle: TextStyle(fontWeight: FontWeight.w400),
                    onRangeSelected: (firstDate, secondDate) {
                      print('onRangeSelected first $firstDate');
                      print('onRangeSelected second $secondDate');
                    },
                    onTapDate: (date) {
                      print('onTap $date');
                    },
                    minDate: DateTime.now(),
                    maxDate: DateTime.now().add(
                      Duration(days: 365),
                    ),
                    renderPostAndPreviousMonthDates: true,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _radioValue,
                            activeColor: Color(0xff7EDABF),
                            onChanged: _handleRadioValueChange,
                          ),
                          Text('Include Saturday')
                        ],
                      ),
                    ),
                    // Calendar(
                    //   //startOnMonday: true,
                    //   weekDays: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
                    //   // events: _events,
                    //   onRangeSelected: (range) =>
                    //       print('Range is ${range.from}, ${range.to}'),
                    //   //onDateSelected: (date) => _handleNewDate(date),
                    //   isExpandable: true,
                    //   eventDoneColor: Colors.green,
                    //   selectedColor: Colors.pink,
                    //   todayColor: Colors.blue,
                    //   eventColor: Colors.grey,
                    //   // locale: 'de_DE',
                    //   // todayButtonText: 'Heute',
                    //   // expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                    //   dayOfWeekStyle: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w800,
                    //       fontSize: 11),
                    // ),
                    SizedBox(width: 10),
                    Container(
                      child: Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _radioValue,
                            activeColor: Color(0xff7EDABF),
                            onChanged: _handleRadioValueChange,
                          ),
                          Text('Include Sunday')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "At what time you want delivery?",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              Container(
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '11:00-11:30',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: AppConstant.appColor,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('11:30-12:00'),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppConstant.appColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('12:30-1:00'),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppConstant.appColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('1:30-2:00'),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppConstant.appColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text('Done'),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
