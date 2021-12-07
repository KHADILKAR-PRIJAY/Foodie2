import 'package:flutter/material.dart';
import 'package:food_app/utils/Constents.dart';

import '../res.dart';

class SelectDateTime extends StatefulWidget {
  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  int _radioValue = 0;

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
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(color: Colors.brown, height: 300),
            ),
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
              height: 50,
              width: 600,
              color: Colors.pink,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Done'),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
