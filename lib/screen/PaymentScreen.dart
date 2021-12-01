import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _radioValue = -1;
  @override
  void initState() {
    super.initState();
  }
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
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(
                            Res.ic_back,
                            width: 16,
                            height: 16,
                          )),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Your Location",
                              style: TextStyle(color: Color(0xffA7A8BC)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "To 89 Palmspring Way Roseville,\nCA 39847",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
                Container(
                  child:  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              child: Image.asset(Res.ic_cash,width: 20,height: 20,),
                              padding: EdgeInsets.only(left: 16,top: 16),
                            ),
                            Padding(
                              child: Text("Pay with Cash"),
                              padding: EdgeInsets.only(left: 16,top: 16),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(

                              child: Radio(
                                value: 0,
                                groupValue: _radioValue,
                                activeColor: Color(0xff7EDABF),
                                onChanged: _handleRadioValueChange,

                              ),
                            ),

                            Padding(
                              child: Image.asset(Res.ic_paytm,width: 20,height: 20,),
                              padding: EdgeInsets.only(top: 16),
                            ),

                            Padding(
                              child: Text("Paytm",style: TextStyle(color: Colors.black),),
                              padding: EdgeInsets.only(left: 16,top: 16),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Radio(
                              value: 0,
                              groupValue: _radioValue,
                              activeColor: Color(0xff7EDABF),
                              onChanged: _handleRadioValueChange,
                            ),

                            Padding(
                              child: Image.asset(Res.ic_phonepay,width: 20,height: 20,),
                              padding: EdgeInsets.only(top: 16),
                            ),
                            Padding(
                              child: Text("PhonePe"),
                              padding: EdgeInsets.only(left: 10,top: 16),
                            )
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Radio(
                              value: 0,
                              groupValue: _radioValue,
                              activeColor: Color(0xff7EDABF),
                              onChanged: _handleRadioValueChange,
                            ),
                            Padding(
                              child: Image.asset(Res.ic_bhim,width: 20,height: 20,),
                              padding: EdgeInsets.only(top: 16),
                            ),
                            Padding(
                              child: Text("Bhim"),
                              padding: EdgeInsets.only(left: 10,top: 16),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/makepayment');
                  },
                  child: Container(
                    child:  Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                             Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(13),
                                 color: Colors.black
                               ),
                               width: 100,
                               height: 40,
                               alignment: Alignment.topRight,
                               margin: EdgeInsets.only(right: 16,top: 16),
                               child: Center(
                                 child: Text("Add Card",style: TextStyle(color: Colors.white),),
                               ),
                             )
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(

                                child: Radio(
                                  value: 0,
                                  groupValue: _radioValue,
                                  activeColor: Color(0xff7EDABF),
                                  onChanged: _handleRadioValueChange,

                                ),
                              ),

                              Padding(
                                child: Image.asset(Res.ic_hdfc,width: 20,height: 20,),
                                padding: EdgeInsets.only(top: 16),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    child: Text("HDFC",style: TextStyle(color: Colors.black),),
                                    padding: EdgeInsets.only(left: 16,top: 16),
                                  ),
                                  Padding(
                                    child: Text("Make card as a default for all paymment",style: TextStyle(color: Colors.black,fontSize: 12),),
                                    padding: EdgeInsets.only(top: 5),
                                  )
                                ],
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Radio(
                                value: 0,
                                groupValue: _radioValue,
                                activeColor: Color(0xff7EDABF),
                                onChanged: _handleRadioValueChange,
                              ),

                              Padding(
                                child: Image.asset(Res.ic_yesbank,width: 20,height: 20,),
                                padding: EdgeInsets.only(top: 16),
                              ),
                              Padding(
                                child: Text("Yes Bank"),
                                padding: EdgeInsets.only(left: 10,top: 16),
                              )
                            ],
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Radio(
                                value: 0,
                                groupValue: _radioValue,
                                activeColor: Color(0xff7EDABF),
                                onChanged: _handleRadioValueChange,
                              ),
                              Padding(
                                child: Image.asset(Res.ic_axisbank,width: 20,height: 20,),
                                padding: EdgeInsets.only(top: 16),
                              ),
                              Padding(
                                child: Text("Axis"),
                                padding: EdgeInsets.only(left: 10,top: 16),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(13)
                    ),
                    width: double.infinity,
                    height: 70,
                    margin: EdgeInsets.only(left: 16,right: 16,top: 26,bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          child: Text("₹300",style: TextStyle(color: Color(0xff7EDABF)),),
                          padding: EdgeInsets.only(top: 16,left: 16),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                child: Text("2 Service",style: TextStyle(color: Colors.white),),
                                padding: EdgeInsets.only(top: 6,left: 16),
                              ),
                            ),
                            Padding(
                              child: Text("Make Payment",style: TextStyle(color: Colors.white),),
                              padding: EdgeInsets.only(top: 6,left: 16,bottom: 10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(

                                padding: EdgeInsets.only(right: 16),
                                child: Image.asset(Res.ic_next_arrow,width: 16,height: 16,)),

                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
