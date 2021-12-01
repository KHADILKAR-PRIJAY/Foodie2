import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/DashboardScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterScreen extends StatefulWidget {

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var isSelect = -1;
  var cuisine = -1;
  var mealPlan = -1;
  var min=0;
  var max=100;
  SfRangeValues _values = SfRangeValues(40.0, 80.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){

                      Navigator.pop(context);
                       },
                    child: Padding(
                        padding: EdgeInsets.only(top: 16, left: 16),
                        child: Image.asset(
                          Res.ic_back,
                          width: 16,
                          height: 16,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Filter",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Meal type",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelect = 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: isSelect == 1
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Breakfast",
                            style: TextStyle(
                                color:
                                    isSelect == 1 ? Colors.white : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelect = 2;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: isSelect == 2
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Lunch",
                            style: TextStyle(
                                color:
                                    isSelect == 2 ? Colors.white : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelect = 3;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: isSelect == 3
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Dinner",
                            style: TextStyle(
                                color:
                                    isSelect == 3 ? Colors.white : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            cuisine = 1;
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              Res.ic_north_meals,
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "North Indian Meals",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cuisine == 1
                                        ? AppConstant.appColor
                                        : Colors.black,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            cuisine = 2;
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              Res.ic_north_meals,
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "South Indian Meals",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cuisine == 2
                                        ? AppConstant.appColor
                                        : Colors.black,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            cuisine = 3;
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              Res.ic_other_meals,
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Other Meals",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cuisine == 3
                                        ? AppConstant.appColor
                                        : Colors.black,
                                    fontSize: 14),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Meal type",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffF3F6FA),
                              ),
                              width: 100,
                              height: 60,
                              child: Center(
                                child: Image.asset(
                                  Res.ic_veg,
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 1, top: 6),
                              child: Text(
                                "Veg",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              decoration: BoxDecoration(
                                color: Color(0xffF3F6FA),
                                shape: BoxShape.circle,
                              ),
                              width: 100,
                              height: 60,
                              child: Center(
                                child: Image.asset(
                                  Res.ic_chiken,
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 1, top: 6),
                              child: Text(
                                "Non-Veg",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              decoration: BoxDecoration(
                                color: Color(0xffF3F6FA),
                                shape: BoxShape.circle,
                              ),
                              width: 100,
                              height: 60,
                              child: Center(
                                child: Image.asset(
                                  Res.ic_vegnonveg,
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 1, top: 6),
                              child: Text(
                                "Veg-Non-Veg",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Meal Plan",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mealPlan = 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: mealPlan == 1
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Weekly",
                            style: TextStyle(
                                color:
                                    mealPlan == 1 ? Colors.white : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mealPlan = 2;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: mealPlan == 2
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Month Plan",
                            style: TextStyle(
                                color:
                                    mealPlan == 2 ? Colors.white : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mealPlan = 3;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: mealPlan == 3
                                ? AppConstant.appColor
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(13)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Trial Meal",
                            style: TextStyle(
                                color:
                                    mealPlan == 3 ? Colors.white : Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Price",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),
              SfRangeSlider(

                min: 0.0,
                max: 100.0,
                values: _values,
                interval: 20,
                showTicks: false,
                showLabels: false,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (SfRangeValues values) {
                  setState(() {
                    _values = values;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Ratings",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontBold),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Image.asset(Res.raings_bar)
              ),

              InkWell(

                onTap: (){

                  sendData();

                },
                child: Container(
                  margin: EdgeInsets.only(top: 26,bottom:16,left: 16,right: 16),
                  decoration: BoxDecoration(
                    color: AppConstant.appColor,
                    borderRadius: BorderRadius.circular(13)
                  ),
                  height: 50,
                  child: Center(
                    child: Text("APPLY FILTERS",style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
            ],
          )),
        ));
  }

  void sendData() {

    Navigator.pop(context,true);
    Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(isSelect,cuisine,mealPlan,"filter",min,max)),);



  }
}
